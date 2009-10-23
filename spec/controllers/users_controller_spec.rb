require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersController, 'routes' do
  should_route :get, '/users', :controller => :users, :action => :index
  should_route :get, '/users/1', :controller => :users, :action => :show, :id => 1
  should_route :get, '/users/new', :controller => :users, :action => :new
  should_route :get, '/users/1/edit', :controller => :users, :action => :edit, :id => 1
  should_route :post, '/users', :controller => :users, :action => :create
  should_route :put, '/users/1', :controller => :users, :action => :update, :id => 1
  should_route :delete, '/users/1', :controller => :users, :action => :destroy, :id => 1
end

describe UsersController do

  integrate_views

  before :each do
    @user = Factory(:user)
    activate_authlogic
    UserSession.create(@user)
  end

  it "should require admin" do
    @user.admin = false
    @user.save!

    get :index
    response.should redirect_to(new_session_path)

    get :new
    response.should redirect_to(new_session_path)

    get :edit, :id => @user.id
    response.should redirect_to(new_session_path)

    user = Factory.build(:user)
    post :create, :user => user.attributes
    response.should redirect_to(new_session_path)

    @user.login = 'new_name'
    post :update, :id => @user.id, :user => @user.attributes
    response.should redirect_to(new_session_path)

    get :destroy, :id => @user.id
    response.should redirect_to(new_session_path)
  end

  it "should require user" do
    UserSession.find.destroy

    get :show, :id => @user.id
    response.should redirect_to(new_session_path)
  end

  it "should list users on :index" do
    get :index

    assigns(:search).should_not be_nil
    assigns(:users).should include(@user)
  end

  it "should assign user on :show" do
    get :show, :id => @user.id

    assigns(:user).should == @user
  end

  it "should assign a new user on :new" do
    get :new

    assigns(:user).should be_new_record
  end

  it "should assign user on :edit" do
    get :edit, :id => @user.id

    assigns(:user).should == @user
  end

  it "should add new user on :create" do
    user = Factory.attributes_for(:user)
    post :create, :user => user

    assigns(:user).should == User.find(assigns(:user).id)
    response.should redirect_to(users_path)
    flash[:message].should_not be_nil
  end

  it "should re-render new when invalid on :create" do
    user = Factory.attributes_for(:user, :login => nil)
    post :create, :user => user

    response.should render_template('new')
  end

  it "should save user on :update" do
    @user.login = 'new_name'
    post :update, :id => @user.id, :user => @user.attributes

    User.find(assigns(:user).id).login.should == @user.login
    response.should redirect_to(users_path)
    flash[:message].should_not be_nil
  end

  it "should re-render edit when invalid on :update" do
    @user.login = nil
    post :update, :id => @user.id, :user => @user.attributes

    response.should render_template('edit')
  end

  it "should delete user on :destroy" do
    user = Factory(:user)
    get :destroy, :id => user.id

    lambda { User.find(user.id) }.should raise_error
    response.should redirect_to(users_path)
    flash[:message].should_not be_nil
  end

  it "should not be able to :destroy self" do
    get :destroy, :id => @user.id

    User.find(@user.id).should == @user
    response.should redirect_to(users_path)
    flash[:message].should_not be_nil
  end

end

