class Product < ActiveRecord::Base

  has_many :sprints
  has_many :stories

  validates_presence_of :name, :slug

  validates_length_of :name, :in => 1..60

  validates_length_of :slug, :in => 1..20
  validates_uniqueness_of :slug
  validates_format_of :slug, :with => /^[a-z0-9]+(\-|[a-z0-9])*$/

end

