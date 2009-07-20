class Story < ActiveRecord::Base

  belongs_to :product

  validates_presence_of :name, :product_id
  validates_length_of :name, :in => 1..200

  validates_numericality_of :estimative
  validates_numericality_of :priority
end

