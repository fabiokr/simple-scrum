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

  PLOT_DATE_FORMAT = "%d/%m"

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

    plot[:expected][:x] = []
    plot[:expected][:y] = []
    plot[:current][:x] = []
    plot[:current][:y] = []

    return plot if self.start.nil? || self.end.nil? || self.tasks.empty?

    plot[:expected][:y] = (0..self.estimated_velocity).to_a.reverse
    plot[:expected][:x] = calculate_expected_x
    plot[:current][:y] = calculate_current_y
    plot[:current][:x] = plot[:expected][:x]

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
  def calculate_expected_x
    dates, current_date = [], self.start

    until current_date > self.end
      dates << current_date.strftime(PLOT_DATE_FORMAT) if current_date.weekday?
      current_date = current_date.next
    end
    dates
  end

  def calculate_current_y
    values, today, current_date, points, stories_end = [], Date.current, self.start, self.estimated_velocity, {}

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

    until current_date > today
      if current_date.weekday?
        stories_end[current_date].each {|story| points -= story.estimative} if stories_end.has_key? current_date
        values << points
      end
      current_date = current_date.next
    end
    values
  end
end

