require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TaskksController, 'routes' do
  should_route :get, '/products/1/sprints/1/taskks', :controller => :taskks, :action => :index, :product_id => 1, :sprint_id => 1
  should_route :get, '/products/1/sprints/1/taskks/1', :controller => :taskks, :action => :show, :id => 1, :product_id => 1, :sprint_id => 1
  should_route :get, '/products/1/sprints/1/taskks/new', :controller => :taskks, :action => :new, :product_id => 1, :sprint_id => 1
  should_route :get, '/products/1/sprints/1/taskks/1/edit', :controller => :taskks, :action => :edit, :id => 1, :product_id => 1, :sprint_id => 1
  should_route :post, '/products/1/sprints/1/taskks', :controller => :taskks, :action => :create, :product_id => 1, :sprint_id => 1
  should_route :put, '/products/1/sprints/1/taskks/1', :controller => :taskks, :action => :update, :id => 1, :product_id => 1, :sprint_id => 1
  should_route :delete, '/products/1/sprints/1/taskks/1', :controller => :taskks, :action => :destroy, :id => 1, :product_id => 1, :sprint_id => 1
end

describe TaskksController do

  integrate_views

  before :each do
    @product = Factory(:product)
    @sprint = Factory(:sprint, :product => @product)
    @task = Factory(:task, :sprint => @sprint)
  end

  after :each do
    assigns(:product).should_not be_nil
    assigns(:sprint).should_not be_nil
  end

  it "should list tasks on :index" do
    get :index, :product_id => @product.id, :sprint_id => @sprint.id

    assigns(:search).should_not be_nil
    assigns(:tasks).should include(@task)
  end

  it "should assign task on :show" do
    get :show, :product_id => @product.id, :sprint_id => @sprint.id, :id => @task.id

    assigns(:task).should == @task
  end

  it "should assign a new task on :new" do
    get :new, :product_id => @product.id, :sprint_id => @sprint.id

    assigns(:task).should be_new_record
  end

  it "should assign task on :edit" do
    get :edit, :product_id => @product.id, :sprint_id => @sprint.id, :id => @task.id

    assigns(:task).should == @task
  end

  it "should add new task on :create" do
    @task = Factory.build(:task)
    post :create, :product_id => @product.id, :sprint_id => @sprint.id, :task => @task.attributes

    assigns(:task).should == Taskk.find(assigns(:task).id)
    response.should redirect_to(product_sprint_taskks_path(@product, @sprint))
    flash[:message].should_not be_nil
  end

  it "should re-render new when invalid on :create" do
    @task = Factory.build(:task, :name => nil)
    post :create, :product_id => @product.id, :sprint_id => @sprint.id, :task => @task.attributes

    response.should render_template('new')
  end

  it "should save task on :update" do
    @task.name = 'new name'
    post :update, :product_id => @product.id, :sprint_id => @sprint.id, :id => @task.id, :task => @task.attributes

    Taskk.find(@task.id).name.should == @task.name
    response.should redirect_to(product_sprint_taskks_path(@product, @sprint))
    flash[:message].should_not be_nil
  end

  it "should re-render edit when invalid on :update" do
    @task.name = nil
    post :update, :product_id => @product.id, :sprint_id => @sprint.id, :id => @task.id, :task => @task.attributes

    response.should render_template('edit')
  end

  it "should delete task on :destroy" do
    get :destroy, :product_id => @product.id, :sprint_id => @sprint.id, :id => @task.id

    lambda { Taskk.find(@task.id) }.should raise_error
    response.should redirect_to(product_sprint_taskks_path(@product, @sprint))
    flash[:message].should_not be_nil
  end

end

