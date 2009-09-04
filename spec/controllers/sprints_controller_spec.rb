require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

def prepare_data
  @product = Factory.build(:product)
  Product.should_receive(:find).with(@product.id.to_s).and_return(@product)
  @sprints = [Factory.build(:sprint, :product => @product)]
  @sprint = @sprints.first
  @product.should_receive(:sprints).and_return(@sprints)
end

describe SprintsController do
  should_route :get, '/products/1/sprints', :controller => :sprints, :action => :index, :product_id => 1
  should_route :get, '/products/1/sprints/1', :controller => :sprints, :action => :show, :id => 1, :product_id => 1
  should_route :get, '/products/1/sprints/new', :controller => :sprints, :action => :new, :product_id => 1
  should_route :get, '/products/1/sprints/1/edit', :controller => :sprints, :action => :edit, :id => 1, :product_id => 1
  should_route :post, '/products/1/sprints', :controller => :sprints, :action => :create, :product_id => 1
  should_route :put, '/products/1/sprints/1', :controller => :sprints, :action => :update, :id => 1, :product_id => 1
  should_route :delete, '/products/1/sprints/1', :controller => :sprints, :action => :destroy, :id => 1, :product_id => 1
end

describe SprintsController, 'on index' do

  integrate_views

  it "should list a product sprints" do
    @sprints = [Factory(:sprint), Factory(:sprint)]

    get :index, :product_id => @sprints.first.product.id

    assigns(:product)
    assert_equal 1, assigns(:sprints).count
  end

end

describe SprintsController, 'on show' do

  integrate_views

  it "should show product sprint" do
    prepare_data
    @sprints.should_receive(:find).with(@sprint.id.to_s).and_return(@sprint)

    get :show, :product_id => @product.id, :id => @sprint.id

    assert_equal @product, assigns(:product)
    assert_equal @sprint, assigns(:sprint)
  end

end

describe SprintsController, 'on new' do

  integrate_views

  it "should edit new product sprint" do
    prepare_data
    @sprints.should_receive(:new).and_return(@sprint)

    get :new, :product_id => @product.id

    assert_equal @product, assigns(:product)
    assert_equal @sprint, assigns(:sprint)
  end

end

describe SprintsController, 'on edit' do

  integrate_views

  it "should edit existing product sprint" do
    prepare_data
    @sprints.should_receive(:find).with(@sprint.id.to_s).and_return(@sprint)

    get :edit, :product_id => @product.id, :id => @sprint.id

    assert_equal @product, assigns(:product)
    assert_equal @sprint, assigns(:sprint)
  end

end

describe SprintsController, 'on create' do

  integrate_views

  before(:each) do
    prepare_data
    @sprints.should_receive(:new).with(@sprint.attributes).and_return(@sprint)
  end

  it "should redirect to index with notice when valid" do
    @sprint.should_receive(:save).and_return(true)

    post :create, :product_id => @product.id, :sprint => @sprint.attributes

    assert_equal @sprint, assigns(:sprint)
    flash[:message].should_not be_nil
    response.should redirect_to(product_sprints_path(@product))
  end

  it "should re-render new when invalid" do
    @sprint.should_receive(:save).and_return(false)

    post :create, :product_id => @product.id, :sprint => @sprint.attributes

    assert_equal @product, assigns(:product)
    response.should render_template('new')
  end

end

describe SprintsController, 'on update' do

  integrate_views

  before(:each) do
    prepare_data
    @sprints.should_receive(:find).with(@sprint.id.to_s).and_return(@sprint)
  end

  it "should redirect to index with notice when valid" do
    @sprint.should_receive(:update_attributes).and_return(true)

    post :update, :product_id => @product.id, :id => @sprint.id, :sprint => @sprint.attributes

    assert_equal @sprint, assigns(:sprint)
    flash[:message].should_not be_nil
    response.should redirect_to(product_sprints_path(@product))
  end

  it "should re-render new when invalid" do
    @sprint.should_receive(:update_attributes).and_return(false)

    post :update, :product_id => @product.id, :id => @sprint.id, :sprint => @sprint.attributes

    assert_equal @product, assigns(:product)
    response.should render_template('edit')
  end

end

describe SprintsController, 'on destroy' do

  integrate_views

  it "should redirect to index" do
    prepare_data
    @sprints.should_receive(:find).with(@sprint.id.to_s).and_return(@sprint)
    @sprint.should_receive(:destroy).and_return(true)

    get :destroy, :product_id => @product.id, :id => @sprint.id

    flash[:message].should_not be_nil
    response.should redirect_to(product_sprints_path(@product))
  end

end

