# == Schema Information
#
# Table name: sprints
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  velocity   :float
#  start      :datetime
#  end        :datetime
#  product_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class Sprint < ActiveRecord::Base
  belongs_to :product

  validates_presence_of :product_id
  validates_length_of :name, :in => 1..60
  validates_numericality_of :velocity
end

