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

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  before(:each) do
    @user = Factory.create(:user)
  end

  it 'should be valid' do
    @user.should be_valid
  end

  it { should have_db_columns :id, :login, :email, :crypted_password, :password_salt, :persistence_token, :perishable_token, :last_login_at, :login_count, :admin, :created_at, :updated_at }
end

