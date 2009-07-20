class Sprint < ActiveRecord::Base
  belongs_to :product

  validates_presence_of :name, :product
  validates_length_of :name, :in => 1..60
  validates_numericality_of :velocity
end

