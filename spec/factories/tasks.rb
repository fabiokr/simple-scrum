Factory.define :task, :class => Task do |u|
  u.add_attribute(:id) {|a| Factory.next(:id)}
  u.name {|a| Faker::Company.catch_phrase}
  u.description {|a| Faker::Lorem.paragraph}
  u.story {|a| a.association(:story) }
  u.sprint {|a| a.association(:sprint) }
  u.status {|a| Task::STATUS.rand}
  u.estimative { rand(100) }

  u.created_at Time.now
  u.updated_at Time.now
end

