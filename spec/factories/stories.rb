Factory.define :story do |u|
  u.add_attribute(:id) {|a| Factory.next(:id)}
  u.name 'As a user I want to do something'
  u.description 'Here goes some aceptance tests descriptions'
  u.estimative { rand(100) }
  u.priority { rand(100) }
  u.product {|a| a.association(:product) }

  u.created_at Time.now
  u.updated_at Time.now
end

