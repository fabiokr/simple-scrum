Factory.define :product do |u|
  u.add_attribute(:id) {|a| Factory.next(:id)}
  u.name 'Some Project'
  u.owner 'The Owner'

  u.created_at Time.now
  u.updated_at Time.now
end

