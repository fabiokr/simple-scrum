# == Schema Information
#
# Table name: sprints
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  estimated_velocity :integer
#  velocity           :integer
#  start              :date
#  end                :date
#  product_id         :integer
#  created_at         :datetime
#  updated_at         :datetime
#  creator_id         :integer
#  updater_id         :integer
#

class Sprint < ActiveRecord::Base
  stampable

  PLOT_DATE_FORMAT = "%e/%m"

  before_save :set_velocity_and_estimated_velocity

  belongs_to :product
  has_many :stories

  validates_presence_of :product_id
  validates_length_of :name, :in => 1..60
  validates_numericality_of :velocity, :allow_nil => true
  validates_numericality_of :estimated_velocity, :allow_nil => true
  validate :end_cannot_be_greater_than_or_equal_start
  validate :must_have_at_least_one_weekday_between_start_and_end

  def self.per_page
    15
  end

  def burndown_plot
    plot = {:expected => {:x => [], :y => []}, :current => {:x => [], :y => []}, :labels => {:x => [], :y => []}}

    return plot if self.start.nil? || self.end.nil? || self.tasks.empty?

    result = calculate_current
    plot[:current][:x], plot[:current][:y] = result[:x], result[:y]
    plot[:labels][:x], plot[:labels][:y] = distribute_labels(result[:x_labels], 15.0), distribute_labels((0..self.estimated_velocity).to_a, 20.0)
    plot[:expected][:x], plot[:expected][:y] = [0, 100], [100, 0]

    plot
  end

  private

  def set_velocity_and_estimated_velocity
    self.velocity = 0 if self.velocity.nil?
    self.estimated_velocity = 0 if self.estimated_velocity.nil?
  end

  def end_cannot_be_greater_than_or_equal_start
    errors.add(:end, "greater_than", {:count => I18n.t('activerecord.attributes.sprint.start')}) if !self.end.nil? && !self.start.nil? && self.end <= self.start
  end

  def must_have_at_least_one_weekday_between_start_and_end
    errors.add(:end, "one_weekday_between") if !self.end.nil? && !self.start.nil? && self.start.weekdays_until(self.end)-1 == 0
  end

  #plot methods
  def calculate_current
    y, x, x_labels, x_value, today, points, stories_end = [], [], [], 0, Date.current, self.estimated_velocity, calculate_stories_end

    weekdays = (self.start..self.end).find_all {|date| date.weekday?}
    weekdays.each do |date|
      x_labels << date.strftime(PLOT_DATE_FORMAT)
      if date <= today
        x << x_value
        x_value += 1
        stories_end[date].each {|story| points -= story.estimative} if stories_end.has_key? date
        y << points
      end
    end

    #distribute the data arround the max value of 100
    factor_x = (100.0/x_labels.size).round_with_precision(1) unless x_labels.empty?
    factor_y = (100.0/y.max).round_with_precision(1) unless y.empty?

    x.collect! {|v| BigDecimal.new((v*factor_x).to_s) }
    y.collect! {|v| BigDecimal.new((v*factor_y).to_s) }

    if x.empty? && y.empty?
      x << BigDecimal.new(0.to_s)
      y << BigDecimal.new(0.to_s)
    end

    {:x => x, :y => y, :x_labels => x_labels}
  end

  private

  #organizes the dates that the stories ended
  def calculate_stories_end
    stories_end = {}
    self.group_tasks_by_story.each do |story, tasks|
      story_ended = true
      tasks.each {|task| story_ended = false if task.status != Task::DONE}

      if story_ended
        date = (tasks.sort_by {|task| task.status_changed_at}).last.status_changed_at.to_date
        stories_end[date] = [] if !stories_end.has_key? date
        stories_end[date] << story
      end
    end
    stories_end
  end

  def distribute_labels(values, max = 20.0)
    factor, labels = (values.size/max).ceil, []
    factor = 1 unless factor > 0
    values.each_index {|i| labels << values[i] if (i%factor) == 0 }
    labels << values.last if labels.last != values.last #adds the last one when it is odd
    labels
  end
end

