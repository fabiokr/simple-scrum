class Sprint < ActiveRecord::Base
  belongs_to :backlog

  validates_presence_of :name
  validates_length_of :name, :in => 1..60
end

