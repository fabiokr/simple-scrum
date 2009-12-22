# == Schema Information
#
# Table name: stories
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  color       :string(255)
#  description :text
#  estimative  :integer
#  priority    :integer
#  product_id  :integer
#  created_at  :datetime
#  updated_at  :datetime
#  creator_id  :integer
#  updater_id  :integer
#

class Story < ActiveRecord::Base
  stampable

  belongs_to :product
  has_many :tasks, :dependent => :destroy

  validates_presence_of :product_id
  validates_length_of :name, :in => 1..200

  validates_numericality_of :estimative
  validates_numericality_of :priority

  def self.per_page
    15
  end

end

