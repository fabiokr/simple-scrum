require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SprintsController, 'routes' do
  should_route :get, '/products/1/sprints', :controller => :sprints, :action => :index, :product_id => 1
  should_route :get, '/products/1/sprints/1', :controller => :sprints, :action => :show, :id => 1, :product_id => 1
  should_route :get, '/products/1/sprints/new', :controller => :sprints, :action => :new, :product_id => 1
  should_route :get, '/products/1/sprints/1/edit', :controller => :sprints, :action => :edit, :id => 1, :product_id => 1
  should_route :post, '/products/1/sprints', :controller => :sprints, :action => :create, :product_id => 1
  should_route :put, '/products/1/sprints/1', :controller => :sprints, :action => :update, :id => 1, :product_id => 1
  should_route :delete, '/products/1/sprints/1', :controller => :sprints, :action => :destroy, :id => 1, :product_id => 1
end

describe SprintsController do

  integrate_views

  before :each do
    @product = Factory(:product)
    @sprint = Factory(:sprint, :product => @product)
  end

  after :each do
    assigns(:product).should_not be_nil
  end

  it "should list sprints on :index" do
    get :index, :product_id => @product.id

    assigns(:search).should_not be_nil
    assigns(:sprints).should include(@sprint)
  end

  it "should assign sprint on :show" do
    get :show, :product_id => @product.id, :id => @sprint.id

    assigns(:sprint).should == @sprint
  end

  it "should assign the last 5 sprints of this product and 10 sprints of all product on :show" do
    15.times do |t|
      Factory(:sprint, :product => @product, :end => t.days.ago)
      Factory(:sprint, :end => t.days.ago)
      Factory(:sprint, :product => @product, :end => t.days.since)
      Factory(:sprint, :end => t.days.since)
    end

    get :show, :product_id => @product.id, :id => @sprint.id

    assigns(:product_sprints).size.should == 5
    assigns(:all_products_sprints).size.should == 10
  end

  it "should assign a new sprint on :new" do
    get :new, :product_id => @product.id

    assigns(:sprint).should be_new_record
  end

  it "should assign sprint on :edit" do
    get :edit, :product_id => @product.id, :id => @sprint.id

    assigns(:sprint).should == @sprint
  end

  it "should add new sprint on :create" do
    @sprint = Factory.build(:sprint)
    post :create, :product_id => @product.id, :sprint => @sprint.attributes

    assigns(:sprint).should == Sprint.find(assigns(:sprint).id)
    response.should redirect_to(product_sprints_path(@product))
    flash[:message].should_not be_nil
  end

  it "should re-render new when invalid on :create" do
    @sprint = Factory.build(:sprint, :name => nil)
    post :create, :product_id => @product.id, :sprint => @sprint.attributes

    response.should render_template('new')
  end

  it "should save sprint on :update" do
    @sprint.name = 'new name'
    post :update, :product_id => @product.id, :id => @sprint.id, :sprint => @sprint.attributes

    Sprint.find(assigns(:sprint).id).name.should == @sprint.name
    response.should redirect_to(product_sprints_path(@product))
    flash[:message].should_not be_nil
  end

  it "should re-render edit when invalid on :update" do
    @sprint.name = nil
    post :update, :product_id => @product.id, :id => @sprint.id, :sprint => @sprint.attributes

    response.should render_template('edit')
  end

  it "should delete sprint on :destroy" do
    get :destroy, :product_id => @product.id, :id => @sprint.id

    lambda { Sprint.find(@sprint.id) }.should raise_error
    response.should redirect_to(product_sprints_path(@product))
    flash[:message].should_not be_nil
  end

end

