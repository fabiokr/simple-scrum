Factory.define :sprint do |u|
  u.add_attribute(:id) {|a| Factory.next(:id)}
  u.name 'Admin Module Sprint'
  u.start Time.now
  u.end Time.now
  u.velocity 0
  u.product {|a| a.association(:product) }

  u.created_at Time.now
  u.updated_at Time.now
end

