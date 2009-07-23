class Product < ActiveRecord::Base

  validates_presence_of :name, :owner

  validates_length_of :name, :in => 1..60
  validates_length_of :owner, :in => 1..60

  has_many :stories
  has_many :sprints

end

