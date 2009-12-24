Factory.define :story do |u|
  u.add_attribute(:id) {|a| Factory.next(:id)}
  u.name {|a| Faker::Company.catch_phrase}
  u.description {|a| Faker::Lorem.paragraph}
  u.estimative { rand(100) }
  u.priority { rand(100) }
  u.product {|a| a.association(:product) }
  u.status {|a| Story::STATUS.rand}

  u.created_at Time.now
  u.updated_at Time.now
end

