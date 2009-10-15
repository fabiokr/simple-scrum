require 'spec_helper'

describe UserSessionsController, 'routes' do
  should_route :get, '/login', :controller => :user_sessions, :action => :new
  should_route :post, '/login', :controller => :user_sessions, :action => :create
  should_route :delete, '/logout', :controller => :user_sessions, :action => :destroy
end

describe UserSessionsController do

  integrate_views

  before :each do
    activate_authlogic
    @user = Factory(:user)
    UserSession.find.destroy
  end

  it "should assign a new session on :new" do
    get :new

    assigns(:user_session).should be_new_record
  end

  it "should login on :create" do
    post :create, :user_session => {:login => @user.login, :password => 'password'}

    assigns(:user_session).should_not be_nil
    response.should redirect_to(root_path)
    flash[:message].should_not be_nil
  end

  it "should re-render new when invalid on :create" do
    post :create, :user_session => {:login => 'invalid', :password => 'invalid'}

    response.should render_template('new')
  end

  it "should clear session on :destroy" do
    UserSession.create(@user)

    get :destroy

    assigns(:current_user_session).record.should be_nil
    response.should redirect_to(root_path)
    flash[:message].should_not be_nil
  end

end

