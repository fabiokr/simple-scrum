Factory.define :story, :default_strategy => :build do |u|
  u.add_attribute(:id) {|a| Factory.next(:id)}
  u.name 'As a user I want to do something'
  u.description 'Here goes some aceptance tests descriptions'
  u.estimative 1
  u.priority 100
  u.product {|a| a.association(:product) }

  u.created_at Time.now
  u.updated_at Time.now
end

