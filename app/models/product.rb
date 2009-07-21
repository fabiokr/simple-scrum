class Product < ActiveRecord::Base

  has_many :sprints
  has_many :stories

  validates_presence_of :name, :owner

  validates_length_of :name, :in => 1..60
  validates_length_of :owner, :in => 1..60

end

