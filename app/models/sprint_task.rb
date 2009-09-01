# == Schema Information
#
# Table name: sprint_tasks
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  story_id    :integer
#  sprint_id   :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class SprintTask < ActiveRecord::Base
  belongs_to :story
  belongs_to :sprint

  validates_presence_of :story, :sprint
  validates_length_of :name, :in => 1..200
end

