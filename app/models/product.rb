# == Schema Information
#
# Table name: products
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  owner      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Product < ActiveRecord::Base

  validates_length_of :name, :in => 1..60
  validates_length_of :owner, :in => 1..60

  has_many :stories
  has_many :sprints

end

