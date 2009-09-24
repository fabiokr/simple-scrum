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
  belongs_to :product
  has_many :tasks, :class_name => 'Taskk'

  validates_presence_of :product_id
  validates_length_of :name, :in => 1..60
  validates_numericality_of :velocity, :allow_nil => true
  validates_numericality_of :estimated_velocity, :allow_nil => true

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
    plot[:expected][:y] = (0..self.estimated_velocity).to_a.reverse

    plot[:current][:x] = []
    plot[:current][:y] = []

    current_date = self.start

    until current_date > self.end
      plot[:expected][:x] << current_date if current_date.weekday?
      current_date = current_date.next
    end

    today, current_date, points, stories_end = Date.today, self.start, self.estimated_velocity, {}

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
        plot[:current][:x] << current_date
        stories_end[current_date].each {|story| points -= story.estimative} if stories_end.has_key? current_date
        plot[:current][:y] << points
      end
      current_date = current_date.next
    end

    plot
  end
end

