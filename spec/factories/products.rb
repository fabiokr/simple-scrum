Factory.define :product do |u|
  u.add_attribute(:id) {|a| Factory.next(:id)}
  u.name {|a| Faker::Company.catch_phrase}
  u.owner {|a| Faker::Company.name}

  u.created_at Time.now
  u.updated_at Time.now
end

