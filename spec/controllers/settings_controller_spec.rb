require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SettingsController, 'routes' do
  should_route :get, '/settings/edit', :controller => :settings, :action => :edit
  should_route :put, '/settings', :controller => :settings, :action => :update
end

describe SettingsController do
  integrate_views

  before :each do
    @user = Factory(:user)
    activate_authlogic
    UserSession.create(@user)
  end

  it "should require user" do
    UserSession.find.destroy

    get :edit
    response.should redirect_to(new_session_path)

    post :update, :user => {:login => 'test'}
    response.should redirect_to(new_session_path)
  end

  it "should assign user on :edit" do
    get :edit

    assigns(:user).should == @user
  end

  it "should save user on :update" do
    post :update, :user => {:email => 'new@email.com', :password => 'new_password', :password_confirmation => 'new_password'}

    @controller.current_user.email.should == 'new@email.com'
    @controller.current_user.email.should == 'new@email.com'

    response.should redirect_to(edit_settings_path)
    flash[:message].should_not be_nil
  end

  it "should re-render edit when invalid on :update" do
    post :update, :user => {:email => 'invalidemail', :password => 'new_password'}

    response.should render_template('edit')
  end
end

