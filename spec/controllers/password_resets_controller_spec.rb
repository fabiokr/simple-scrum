require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PasswordResetsController, 'routes' do
  should_route :get, '/password_resets/new', :controller => :password_resets, :action => :new
  should_route :post, '/password_resets', :controller => :password_resets, :action => :create
  should_route :get, '/password_resets/1/edit', :controller => :password_resets, :action => :edit, :id => 1
  should_route :put, '/password_resets/1', :controller => :password_resets, :action => :update, :id => 1
end

describe PasswordResetsController do

  integrate_views

  before(:each) do
    @user = Factory.create(:user)
    activate_authlogic
  end

  it "should render :new" do
    get :new
    response.should render_template(:new)
  end

  it 'should re-render new when email does not exists on create' do
    get :create, :email => 'notexistent@email.com'
    response.should render_template(:new)
    flash[:notice].should_not be_nil
  end

  it 'should deliver password reset instructions' do
    get :create, :email => @user.email
    flash[:notice].should_not be_nil
    response.should render_template(:new)
  end

  it 'should redirect on invalid token on edit' do
    get :edit, :id => 'invalidtoken'
    flash[:notice].should_not be_nil
    response.should redirect_to(new_password_reset_url)
  end

  it 'should render edit on valid token on edit' do
    get :edit, :id => @user.perishable_token
    assigns(:user).should_not be_nil
    response.should render_template(:edit)
  end

  it 'should save the new password on update' do
    post :update, :id => @user.perishable_token, :user => {:password => '123456', :password_confirmation => '123456'}
    response.should redirect_to(root_url)
    flash[:notice].should_not be_nil
  end

  it 'should re-render edit on update when password is invalid' do
    post :update, :id => @user.perishable_token, :user => {:password => '123456', :password_confirmation => '654321'}
    assigns(:user).should_not be_nil
    response.should render_template(:edit)
  end

end

