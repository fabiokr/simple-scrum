# == Schema Information
#
# Table name: tasks
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  status      :string(255)
#  description :text
#  estimative  :integer
#  story_id    :integer
#  sprint_id   :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Taskk < ActiveRecord::Base

  set_table_name 'tasks'

  STATUS = %w( todo doing done )

  belongs_to :story
  belongs_to :sprint

  default_scope :order => 'unplanned ASC, estimative DESC'

  validates_presence_of :story, :sprint
  validates_length_of :name, :in => 1..200
  validates_inclusion_of :status, :in => STATUS, :allow_nil => true
  validates_numericality_of :estimative

  before_save :set_default_status
  after_save :update_sprint_estimated_velocity
  after_save :update_sprint_velocity

  private

    def set_default_status
      self.status = STATUS[0] if self.status.nil?
    end

    def update_sprint_estimated_velocity
      estimated_velocity = 0
      sprint = self.sprint
      sprint.tasks.each do |task|
        estimated_velocity += task.estimative
      end
      sprint.estimated_velocity = estimated_velocity
      sprint.save
    end

    def update_sprint_velocity
      velocity = 0
      sprint = self.sprint

      #separates the sprint tasks into groups of story
      stories = {}
      sprint.tasks.each do |task|
        stories[task.story] = [] unless stories.has_key? task.story
        stories[task.story] << task
      end

      #evaluates if all tasks of a story have been completed
      stories.each do |story, tasks|
        completed = true
        tasks.each {|task| completed = false if task.status != Taskk::STATUS[2]}
        velocity += story.estimative if completed
      end

      sprint.velocity = velocity
      sprint.save!
    end

end

