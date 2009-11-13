# == Schema Information
#
# Table name: products
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  owner      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  creator_id :integer
#  updater_id :integer
#

class Product < ActiveRecord::Base
  stampable

  validates_length_of :name, :in => 1..60
  validates_length_of :owner, :in => 1..60

  has_many :stories, :dependent => :destroy
  has_many :sprints, :dependent => :destroy

end

