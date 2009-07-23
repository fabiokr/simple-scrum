require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  context 'on GET to :index' do
    setup do
      @products = [Factory(:product), Factory(:product)]
      get :index
    end

    should_respond_with :success
    should_assign_to(:search)
    should_assign_to(:products) {@products}
    should 'assign products' do
      assert_equal @products.size, assigns(:products).size
    end
  end

  context "on GET to :new" do
    setup do
      get :new
    end

    should_respond_with :success
    should_assign_to :product
  end

  context "on POST to :create" do
    setup do
      @product = Factory.build(:product)
      post :create, :product => @product.attributes
    end

    should_redirect_to('show') { products_path }
    should_set_the_flash_to /.*/
    should 'create product' do
      assert_equal 1, Product.count
    end
  end

  context "on POST to :create with invalid records" do
    setup do
      @product = Product.new
      post :create, :product => @product.attributes
    end

    should_render_template :new
    should 'not create product' do
      assert_equal 0, Product.count
    end
  end

  context "on GET to :show" do
    setup do
      @product = Factory(:product)
      get :show, :id => @product.id
    end

    should_respond_with :success
    should_assign_to(:product) {@product}
  end

  context "on GET to :edit" do
    setup do
      @product = Factory(:product)
      get :edit, :id => @product.id
    end

    should_respond_with :success
    should_assign_to(:product) {@product}
  end

  context "on POST to :update" do
    setup do
      @product = Factory(:product)
      post :update, :id => @product.id, :product => {:name => 'New name'}
    end

    should_redirect_to('show') {products_path}
    should_set_the_flash_to /.*/
    should 'update product' do
      assert_equal 'New name', Product.find(@product.id).name
    end
  end

  context "on POST to :update with invalid records" do
    setup do
      @product = Factory(:product)
      post :update, :id => @product.id, :product => {:name => ''}
    end

    should_render_template :edit
    should 'not update product' do
      assert_not_equal '', Product.find(@product.id).name
    end
  end

  context "on DELETE to :destroy" do
    setup do
      @product = Factory(:product)
      delete :destroy, :id => @product.id
    end

    should_redirect_to('index') {products_path}
    should_set_the_flash_to /.*/
    should 'destroy product' do
      assert_equal 0, Product.count
    end
  end
end

