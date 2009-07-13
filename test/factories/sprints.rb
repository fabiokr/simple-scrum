Factory.define :sprint, :default_strategy => :build do |u|
  u.add_attribute(:id) {|a| Factory.next(:id)}
  u.name 'Admin Module Sprint'
  u.start Time.now
  u.end Time.now

  u.backlog {|a| a.association(:backlog) }

  u.created_at Time.now
  u.updated_at Time.now
end

