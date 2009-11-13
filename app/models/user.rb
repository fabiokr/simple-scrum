# == Schema Information
#
# Table name: users
#
#  id                :integer         not null, primary key
#  login             :string(255)
#  email             :string(255)
#  crypted_password  :string(255)
#  password_salt     :string(255)
#  persistence_token :string(255)
#  perishable_token  :string(255)
#  last_login_at     :datetime
#  login_count       :integer
#  admin             :boolean
#  created_at        :datetime
#  updated_at        :datetime
#

class User < ActiveRecord::Base
  acts_as_authentic
  is_gravtastic!
end

