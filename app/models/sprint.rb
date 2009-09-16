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

class Sprint < ActiveRecord::Base
  belongs_to :product

  has_many :tasks, :class_name => 'Taskk'

  validates_presence_of :product_id
  validates_length_of :name, :in => 1..60
  validates_numericality_of :velocity, :allow_nil => true
  validates_numericality_of :estimated_velocity, :allow_nil => true
end

