require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProductsController, 'routes' do
  should_route :get, '/products', :controller => :products, :action => :index
  should_route :get, '/products/1', :controller => :products, :action => :show, :id => 1
  should_route :get, '/products/new', :controller => :products, :action => :new
  should_route :get, '/products/1/edit', :controller => :products, :action => :edit, :id => 1
  should_route :post, '/products', :controller => :products, :action => :create
  should_route :put, '/products/1', :controller => :products, :action => :update, :id => 1
  should_route :delete, '/products/1', :controller => :products, :action => :destroy, :id => 1
end

describe ProductsController do

  integrate_views

  before :each do
    @product = Factory(:product)
    @user = Factory(:user)
    activate_authlogic
    UserSession.create(@user)
  end

  it "should require user" do
    UserSession.find.destroy

    get :index
    response.should redirect_to(new_session_path)

    get :show, :id => @product.id
    response.should redirect_to(new_session_path)

    get :new
    response.should redirect_to(new_session_path)

    get :edit, :id => @product.id
    response.should redirect_to(new_session_path)

    product = Factory.build(:product)
    post :create, :product => product.attributes
    response.should redirect_to(new_session_path)

    @product.name = 'new name'
    post :update, :id => @product.id, :product => @product.attributes
    response.should redirect_to(new_session_path)

    get :destroy, :id => @product.id
    response.should redirect_to(new_session_path)
  end

  it "should user stamp the product on create and update" do
    product = Factory.build(:product)
    post :create, :product => product.attributes
    assigns(:product).creator_id.should == @user.id
    assigns(:product).updater_id.should == @user.id

    user = Factory(:user)
    product = Factory(:product, :creator => user, :updater => user)

    post :update, :id => product.id, :product => {:name => 'new name'}
    assigns(:product).creator_id.should == user.id
    assigns(:product).updater_id.should == @user.id
  end

  it "should list products on :index" do
    get :index

    assigns(:search).should_not be_nil
    assigns(:products).should include(@product)
  end

  it "should assign product on :show" do
    get :show, :id => @product.id

    assigns(:product).should == @product
  end

  it "should assign a new product on :new" do
    get :new

    assigns(:product).should be_new_record
  end

  it "should assign product on :edit" do
    get :edit, :id => @product.id

    assigns(:product).should == @product
  end

  it "should add new product on :create" do
    @product = Factory.build(:product)
    post :create, :product => @product.attributes

    assigns(:product).should == Product.find(assigns(:product).id)
    response.should redirect_to(products_path)
    flash[:message].should_not be_nil
  end

  it "should re-render new when invalid on :create" do
    @product = Factory.build(:product, :name => nil)
    post :create, :product => @product.attributes

    response.should render_template('new')
  end

  it "should save product on :update" do
    @product.name = 'new name'
    post :update, :id => @product.id, :product => @product.attributes

    Product.find(assigns(:product).id).name.should == @product.name
    response.should redirect_to(products_path)
    flash[:message].should_not be_nil
  end

  it "should re-render edit when invalid on :update" do
    @product.name = nil
    post :update, :id => @product.id, :product => @product.attributes

    response.should render_template('edit')
  end

  it "should delete product on :destroy" do
    get :destroy, :id => @product.id

    lambda { Product.find(@product.id) }.should raise_error
    response.should redirect_to(products_path)
    flash[:message].should_not be_nil
  end

end

