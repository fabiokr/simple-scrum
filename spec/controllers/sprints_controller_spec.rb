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
    @user = Factory(:user)
    activate_authlogic
    UserSession.create(@user)
  end

  after :each do
    assigns(:product).should_not be_nil unless assigns(:current_user_session).nil?
  end

  it "should require user" do
    UserSession.find.destroy

    get :index, :product_id => @product.slug
    response.should redirect_to(new_session_path)

    get :show, :product_id => @product.slug, :id => @sprint.id
    response.should redirect_to(new_session_path)

    get :new, :product_id => @product.slug
    response.should redirect_to(new_session_path)

    get :edit, :product_id => @product.slug, :id => @sprint.id
    response.should redirect_to(new_session_path)

    sprint = Factory.build(:sprint)
    post :create, :product_id => @product.slug, :sprint => sprint.attributes
    response.should redirect_to(new_session_path)

    @sprint.name = 'new name'
    post :update, :product_id => @product.slug, :id => @sprint.id, :sprint => @sprint.attributes
    response.should redirect_to(new_session_path)

    get :destroy, :product_id => @product.slug, :id => @sprint.id
    response.should redirect_to(new_session_path)
  end

  it "should user stamp the sprint on create and update" do
    sprint = Factory.build(:sprint)
    post :create, :product_id => @product.slug, :sprint => sprint.attributes
    assigns(:sprint).creator_id.should == @user.id
    assigns(:sprint).updater_id.should == @user.id

    user = Factory(:user)
    sprint = Factory(:sprint, :product => @product, :creator => user, :updater => user)

    post :update, :product_id => @product.slug, :id => sprint.id, :sprint => {:name => 'new name'}
    assigns(:sprint).creator_id.should == user.id
    assigns(:sprint).updater_id.should == @user.id
  end

  it "should list sprints on :index" do
    get :index, :product_id => @product.slug

    assigns(:search).should_not be_nil
    assigns(:sprints).should include(@sprint)
  end

  it "should assign sprint on :show" do
    get :show, :product_id => @product.slug, :id => @sprint.id

    assigns(:sprint).should == @sprint
  end

  it "should assign the last 5 sprints of this product and 10 sprints of all product on :show" do
    15.times do |t|
      Factory(:sprint, :product => @product, :start => (t+10).days.ago.to_date, :end => t.days.ago.to_date)
      Factory(:sprint, :start => (t+10).days.ago.to_date, :end => t.days.ago.to_date)
      Factory(:sprint, :product => @product, :start => (t-10).days.since.to_date, :end => t.days.since.to_date)
      Factory(:sprint, :start => (t-10).days.since.to_date, :end => t.days.since.to_date)
    end

    get :show, :product_id => @product.slug, :id => @sprint.id

    assigns(:product_sprints).size.should == 5
    assigns(:all_products_sprints).size.should == 10
  end

  it "should assign a new sprint on :new" do
    get :new, :product_id => @product.slug

    assigns(:sprint).should be_new_record
  end

  it "should assign sprint on :edit" do
    get :edit, :product_id => @product.slug, :id => @sprint.id

    assigns(:sprint).should == @sprint
  end

  it "should add new sprint on :create" do
    @sprint = Factory.build(:sprint)
    post :create, :product_id => @product.slug, :sprint => @sprint.attributes

    assigns(:sprint).should == Sprint.find(assigns(:sprint).id)
    response.should redirect_to(edit_product_sprint_path(@product.slug, assigns(:sprint)))
    flash[:message].should_not be_nil
  end

  it "should re-render new when invalid on :create" do
    @sprint = Factory.build(:sprint, :name => nil)
    post :create, :product_id => @product.slug, :sprint => @sprint.attributes

    response.should render_template('new')
  end

  it "should save sprint on :update" do
    @sprint.name = 'new name'
    post :update, :product_id => @product.slug, :id => @sprint.id, :sprint => @sprint.attributes

    Sprint.find(assigns(:sprint).id).name.should == @sprint.name
    redirect_to(edit_product_sprint_path(@product.slug, @sprint))
    flash[:message].should_not be_nil
  end

  it "should re-render edit when invalid on :update" do
    @sprint.name = nil
    post :update, :product_id => @product.slug, :id => @sprint.id, :sprint => @sprint.attributes

    response.should render_template('edit')
  end

  it "should delete sprint on :destroy" do
    get :destroy, :product_id => @product.slug, :id => @sprint.id

    lambda { Sprint.find(@sprint.id) }.should raise_error
    response.should redirect_to(product_sprints_path(@product.slug))
    flash[:message].should_not be_nil
  end

  it "should delete sprint on :destroy and set header to ok if xhr" do
    xhr 'get', :destroy, :product_id => @product.slug, :id => @sprint.id

    lambda { Sprint.find(@sprint.id) }.should raise_error
    response.should_not render_template
    flash[:message].should_not be_nil
  end

end

