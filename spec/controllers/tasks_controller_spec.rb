require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TasksController, 'routes' do
  should_route :get, '/products/1/sprints/1/tasks/1', :controller => :tasks, :action => :show, :id => 1, :product_id => 1, :sprint_id => 1
  should_route :get, '/products/1/sprints/1/tasks/new', :controller => :tasks, :action => :new, :product_id => 1, :sprint_id => 1
  should_route :get, '/products/1/sprints/1/tasks/1/edit', :controller => :tasks, :action => :edit, :id => 1, :product_id => 1, :sprint_id => 1
  should_route :post, '/products/1/sprints/1/tasks', :controller => :tasks, :action => :create, :product_id => 1, :sprint_id => 1
  should_route :put, '/products/1/sprints/1/tasks/1', :controller => :tasks, :action => :update, :id => 1, :product_id => 1, :sprint_id => 1
  should_route :delete, '/products/1/sprints/1/tasks/1', :controller => :tasks, :action => :destroy, :id => 1, :product_id => 1, :sprint_id => 1
end

describe TasksController do

  integrate_views

  before :each do
    @product = Factory(:product)
    @sprint = Factory(:sprint, :product => @product)
    @task = Factory(:task, :sprint => @sprint)
    @user = Factory(:user)
    activate_authlogic
    UserSession.create(@user)
  end

  after :each do
    assigns(:product).should_not be_nil unless assigns(:current_user_session).nil?
    assigns(:sprint).should_not be_nil unless assigns(:current_user_session).nil?
  end

  it "should require user" do
    UserSession.find.destroy

    get :show, :product_id => @product.slug, :sprint_id => @sprint.id, :id => @task.id
    response.should redirect_to(new_session_path)

    get :new, :product_id => @product.slug, :sprint_id => @sprint.id
    response.should redirect_to(new_session_path)

    get :edit, :product_id => @product.slug, :sprint_id => @sprint.id, :id => @task.id
    response.should redirect_to(new_session_path)

    task = Factory.build(:task)
    post :create, :product_id => @product.slug, :sprint_id => @sprint.id, :task => task.attributes
    response.should redirect_to(new_session_path)

    @task.name = 'new name'
    post :update, :product_id => @product.slug, :sprint_id => @sprint.id, :id => @task.id, :task => @task.attributes
    response.should redirect_to(new_session_path)

    get :destroy, :product_id => @product.slug, :sprint_id => @sprint.id, :id => @task.id
    response.should redirect_to(new_session_path)
  end

  it "should user stamp the task on create and update" do
    task = Factory.build(:task)
    post :create, :product_id => @product.slug, :sprint_id => @sprint.id, :task => task.attributes
    assigns(:task).creator_id.should == @user.id
    assigns(:task).updater_id.should == @user.id

    user = Factory(:user)
    task = Factory(:task, :sprint => @sprint, :creator => user, :updater => user)

    post :update, :product_id => @product.slug, :sprint_id => @sprint.id, :id => task.id, :task => {:name => 'new name'}
    assigns(:task).creator_id.should == user.id
    assigns(:task).updater_id.should == @user.id
  end

  it "should assign task on :show" do
    get :show, :product_id => @product.slug, :sprint_id => @sprint.id, :id => @task.id

    assigns(:task).should == @task
  end

  it "should assign a new task on :new" do
    get :new, :product_id => @product.slug, :sprint_id => @sprint.id

    assigns(:task).should be_new_record
  end

  it "should assign task on :edit" do
    get :edit, :product_id => @product.slug, :sprint_id => @sprint.id, :id => @task.id

    assigns(:task).should == @task
  end

  it "should add new task on :create" do
    @task = Factory.build(:task)
    post :create, :product_id => @product.slug, :sprint_id => @sprint.id, :task => @task.attributes

    assigns(:task).should == Task.find(assigns(:task).id)
    response.should redirect_to(edit_product_sprint_task_path(@product.slug, @sprint, assigns(:task)))
    flash[:message].should_not be_nil
  end

  it "should re-render new when invalid on :create" do

    @task = Factory.build(:task, :name => nil)
    post :create, :product_id => @product.slug, :sprint_id => @sprint.id, :task => @task.attributes

    response.should render_template('new')
  end

  it "should save task on :update" do
    @task.name = 'new name'
    post :update, :product_id => @product.slug, :sprint_id => @sprint.id, :id => @task.id, :task => @task.attributes

    Task.find(@task.id).name.should == @task.name
    response.should redirect_to(edit_product_sprint_task_path(@product.slug, @sprint, @task))
    flash[:message].should_not be_nil
  end

  it "should re-render edit when invalid on :update" do
    @task.name = nil
    post :update, :product_id => @product.slug, :sprint_id => @sprint.id, :id => @task.id, :task => @task.attributes

    response.should render_template('edit')
  end

  it "should delete task on :destroy" do
    get :destroy, :product_id => @product.slug, :sprint_id => @sprint.id, :id => @task.id

    lambda { Task.find(@task.id) }.should raise_error
    response.should redirect_to(product_sprint_path(@product.slug, @sprint))
    flash[:message].should_not be_nil
  end

  it "should delete task on :destroy and set header to ok if xhr" do
    xhr 'get', :destroy, :product_id => @product.slug, :sprint_id => @sprint.id, :id => @task.id

    lambda { Task.find(@task.id) }.should raise_error
    response.should_not render_template
    flash[:message].should_not be_nil
  end

end

