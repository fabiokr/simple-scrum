class Backlog < ActiveRecord::Base

  validates_presence_of :project_name, :slug

  validates_length_of :project_name, :in => 1..60

  validates_length_of :slug, :in => 1..20
  validates_uniqueness_of :slug
  validates_format_of :slug, :with => /^[a-z0-9]+(\-|[a-z0-9])*$/

end

