Factory.define :backlog_item, :default_strategy => :build do |u|
  u.add_attribute(:id) {|a| Factory.next(:id)}
  u.story 'As a user I want to do something'
  u.description 'Here goes some aceptance tests descriptions'
  u.estimative 1

  u.backlog {|a| a.association(:backlog) }

  u.created_at Time.now
  u.updated_at Time.now
end

Factory.define :backlog_item_with_father, :parent => :backlog_item, :default_strategy => :build do |u|
  u.backlog_item_id {|a| a.association(:backlog_item) }
end

