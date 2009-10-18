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

