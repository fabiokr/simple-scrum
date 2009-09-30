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
#
#require 'gchart'

class Sprint < ActiveRecord::Base

  PLOT_DATE_FORMAT = "%e/%m"

  before_save :set_velocity_and_estimated_velocity

  belongs_to :product
  has_many :tasks, :class_name => 'Taskk'

  validates_presence_of :product_id
  validates_length_of :name, :in => 1..60
  validates_numericality_of :velocity, :allow_nil => true
  validates_numericality_of :estimated_velocity, :allow_nil => true
  validate :end_cannot_be_greater_than_or_equal_start

  def group_tasks_by_story
    stories = {}
    self.tasks.each do |task|
      stories[task.story] = [] if stories[task.story].nil?
      stories[task.story] << task
    end
    stories
  end

  def burndown_plot
    plot = {}
    plot[:expected] = {}
    plot[:current] = {}
    plot[:labels] = {}

    plot[:expected][:x] = []
    plot[:expected][:y] = []
    plot[:current][:x] = []
    plot[:current][:y] = []
    plot[:labels][:x] = []
    plot[:labels][:y] = []

    return plot if self.start.nil? || self.end.nil? || self.tasks.empty?

    result = calculate_current
    plot[:current][:y] = result[:y]
    plot[:current][:x] = result[:x]

    plot[:labels][:x] = distribute_labels(result[:x_labels], 15.0)
    plot[:labels][:y] = distribute_labels((0..self.estimated_velocity).to_a, 20.0)

    plot[:expected][:y] = [100, 0]
    plot[:expected][:x] = [0, 100]

    plot
  end

  private

  def set_velocity_and_estimated_velocity
    self.velocity = 0 if self.velocity.nil?
    self.estimated_velocity = 0 if self.estimated_velocity.nil?
  end

  def end_cannot_be_greater_than_or_equal_start
    errors.add(:end, "greater_than", {:count => 'activerecord.attributes.sprint.start'}) if !self.end.nil? && !self.start.nil? && self.end <= self.start
  end

  #plot methods
  def calculate_current
    y, x, x_labels, x_value, today, current_date, points, stories_end = [], [], [], 0, Date.current, self.start, self.estimated_velocity, {}

    #organizes the dates that the stories ended
    self.group_tasks_by_story.each do |story, tasks|
      story_ended = true
      tasks.each {|task| story_ended = false if task.status != Taskk::DONE}

      if story_ended
        date = (tasks.sort_by {|task| task.status_changed_at}).last.status_changed_at.to_date
        stories_end[date] = [] if !stories_end.has_key? date
        stories_end[date] << story
      end
    end

    until current_date > self.end
      if current_date.weekday?
        x_labels << current_date.strftime(PLOT_DATE_FORMAT)
        if current_date <= today
          x << x_value
          x_value += 1
          stories_end[current_date].each {|story| points -= story.estimative} if stories_end.has_key? current_date
          y << points
        end
      end
      current_date = current_date.next
    end

    #distribute the data arround the max value of 100
    factor_x, factor_y  = (100.0/x_labels.size).round_with_precision(1), (100.0/y.max).round_with_precision(1)

    x.collect! {|v| BigDecimal.new((v*factor_x).to_s) }
    y.collect! {|v| BigDecimal.new((v*factor_y).to_s) }

    {:x => x, :y => y, :x_labels => x_labels}
  end

  def distribute_labels(values, max = 20.0)
    factor, labels = (values.size/max).ceil, []
    factor = 1 unless factor > 0
    values.each_index {|i| labels << values[i] if (i%factor) == 0 }
    labels << values.last if labels.last != values.last #adds the last one when it is odd
    labels
  end
end

