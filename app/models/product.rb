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

  before_save :create_slug

  validates_length_of :name, :in => 1..60
  validates_length_of :owner, :in => 1..60
  validates_uniqueness_of :slug, :name

  has_many :stories, :dependent => :destroy
  has_many :sprints, :dependent => :destroy

  def self.per_page
    15
  end

  private

  def create_slug
    self.slug = self.name.parameterize
  end

end

