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

  default_scope :order => 'estimative DESC'

  validates_presence_of :story, :sprint
  validates_length_of :name, :in => 1..200
  validates_inclusion_of :status, :in => STATUS, :allow_nil => true
  validates_numericality_of :estimative

  before_save :set_default_status

  private

    def set_default_status
      self.status = STATUS[0] if self.status.nil?
    end
end

