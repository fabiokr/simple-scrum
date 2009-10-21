Factory.define :user do |u|
  salt = ''
  u.add_attribute(:id) {|a| Factory.next(:id)}
  u.login {|a| Faker::Internet.user_name}
  u.email {|a| Faker::Internet.email}
  u.password 'password'
  u.password_confirmation 'password'
  u.admin true

  u.created_at Time.now
  u.updated_at Time.now
end

