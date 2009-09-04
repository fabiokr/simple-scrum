require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProductsController do
  should_route :get, '/products', :controller => :products, :action => :index
  should_route :get, '/products/1', :controller => :products, :action => :show, :id => 1
  should_route :get, '/products/new', :controller => :products, :action => :new
  should_route :get, '/products/1/edit', :controller => :products, :action => :edit, :id => 1
  should_route :post, '/products', :controller => :products, :action => :create
  should_route :put, '/products/1', :controller => :products, :action => :update, :id => 1
  should_route :delete, '/products/1', :controller => :products, :action => :destroy, :id => 1
end

describe ProductsController, 'on index' do

  integrate_views

  it "should list products" do
    get :index, :page => 1, :search => {:name_like => 'test'}

    assigns(:search)
    assigns(:products)
  end

end

describe ProductsController, 'on show' do

  integrate_views

  it "should show product" do
    @product = Factory.build(:product)
    Product.should_receive(:find).with(@product.id.to_s).and_return(@product)

    get :show, :id => @product.id

    assert_equal @product, assigns(:product)
  end

end

describe ProductsController, 'on new' do

  integrate_views

  it "should edit new product" do
    @product = Factory.build(:product)
    Product.should_receive(:new).and_return(@product)

    get :new

    assert_equal @product, assigns(:product)
  end

end

describe ProductsController, 'on edit' do

  integrate_views

  it "should edit existing product" do
    @product = Factory.build(:product)
    Product.should_receive(:find).with(@product.id.to_s).and_return(@product)

    get :edit, :id => @product.id

    assert_equal @product, assigns(:product)
  end

end

describe ProductsController, 'on create' do

  integrate_views

  before(:each) do
    @product = Factory.build(:product)
    Product.should_receive(:new).with(@product.attributes).and_return(@product)
  end

  it "should redirect to index with notice when valid" do
    @product.should_receive(:save).and_return(true)

    post :create, :product => @product.attributes

    assert_equal @product, assigns(:product)
    flash[:message].should_not be_nil
    response.should redirect_to(products_path)
  end

  it "should re-render new when invalid" do
    @product.should_receive(:save).and_return(false)

    post :create, :product => @product.attributes

    assert_equal @product, assigns(:product)
    response.should render_template('new')
  end

end

describe ProductsController, 'on update' do

  integrate_views

  before(:each) do
    @product = Factory.build(:product)
    Product.should_receive(:find).with(@product.id.to_s).and_return(@product)
  end

  it "should redirect to index with notice when valid" do
    @product.should_receive(:update_attributes).and_return(true)

    post :update, :id => @product.id, :product => @product.attributes

    assert_equal @product, assigns(:product)
    flash[:message].should_not be_nil
    response.should redirect_to(products_path)
  end

  it "should re-render edit when invalid" do
    @product.should_receive(:update_attributes).and_return(false)

    post :update, :id => @product.id, :product => @product.attributes

    assert_equal @product, assigns(:product)
    response.should render_template('edit')
  end

end

describe ProductsController, 'on destroy' do

  integrate_views

  it "should redirect to index" do
    @product = Factory.build(:product)
    Product.should_receive(:find).with(@product.id.to_s).and_return(@product)
    @product.should_receive(:destroy).and_return(true)

    get :destroy, :id => @product.id

    flash[:message].should_not be_nil
    response.should redirect_to(products_path)
  end

end

