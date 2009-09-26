Factory.define :sprint do |u|
  u.add_attribute(:id) {|a| Factory.next(:id)}
  u.name {|a| Faker::Company.catch_phrase}
  u.start Date.current
  u.end 1.day.since.to_date
  u.velocity 0
  u.product {|a| a.association(:product) }

  u.created_at Time.now
  u.updated_at Time.now
end

