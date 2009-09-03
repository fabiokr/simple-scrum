Factory.define :task, :class => Taskk do |u|
  u.add_attribute(:id) {|a| Factory.next(:id)}
  u.name 'Task refering to a Story'
  u.description 'Here goes some aceptance tests descriptions'
  u.story {|a| a.association(:story) }
  u.sprint {|a| a.association(:sprint) }
  u.status 'not_started'

  u.created_at Time.now
  u.updated_at Time.now
end

