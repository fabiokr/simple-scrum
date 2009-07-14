Factory.sequence :slug do |n|
  "project-#{n}"
end

Factory.define :backlog, :default_strategy => :build do |u|
  u.add_attribute(:id) {|a| Factory.next(:id)}
  u.project_name 'My Project'
  u.slug { Factory.next(:slug) }

  u.created_at Time.now
  u.updated_at Time.now
end

