require 'test_helper'

class ProductsControllerTest < ActionController::TestCase

  context 'on GET to :index' do
    setup do
      @products = [Factory(:product), Factory(:product)].paginate
      @search = Product.new_search

      @search.stubs(:all => @products, :count => @products.size)
      Product.expects(:new_search => @search)

      get :index
    end

    should_respond_with :success
    should_assign_to(:search) {@search}
    should_assign_to(:products) {@products}
  end

  context "on GET to :new" do
    setup do
      get :new
    end

    should_respond_with :success
  end

  context "on POST to :create" do
    setup do
      @product = Factory(:product)
      Product.expects(:new => @product)
      @product.expects(:save => true)

      post :create, :product => @product.attributes
    end

    should_redirect_to('show') {product_path(@product)}
    should_set_the_flash_to I18n.t('system.successfully_created', :model => I18n.t('activerecord.models.product'))
  end

  context "on POST to :create with invalid records" do
    setup do
      @product = Factory(:product)
      Product.expects(:new => @product)
      @product.expects(:save => false)
      mock_record_invalid(@product)

      post :create, :product => @product.attributes
    end

    should_render_template :new
  end

  context "on GET to :show" do
    setup do
      @product = Factory(:product)
      Product.expects(:find => @product)

      get :show, :id => @product.id
    end

    should_respond_with :success
    should_assign_to(:product) {@product}
  end

  context "on GET to :edit" do
    setup do
      @product = Factory(:product)
      Product.expects(:find => @product)

      get :edit, :id => @product.id
    end

    should_respond_with :success
    should_assign_to(:product) {@product}
  end

  context "on POST to :update" do
    setup do
      @product = Factory(:product)
      Product.expects(:find => @product)
      @product.expects(:update_attributes => true)

      post :update, :id => @product.id, :product => @product.attributes
    end

    should_redirect_to('show') {product_path(@product)}
    should_set_the_flash_to I18n.t('system.successfully_updated', :model => I18n.t('activerecord.models.product'))
  end

  context "on POST to :update with invalid records" do
    setup do
      @product = Factory(:product)
      Product.expects(:find => @product)
      @product.expects(:update_attributes => false)

      post :update, :id => @product.id, :product => @product.attributes
    end

    should_render_template :edit
  end

  context "on DELETE to :destroy" do
    setup do
      @product = Factory(:product)
      Product.expects(:find => @product)
      @product.expects(:destroy => true)

      delete :destroy, :id => @product.id
    end

    should_redirect_to('index') {products_path}
    should_set_the_flash_to I18n.t('system.successfully_destroyed', :model => I18n.t('activerecord.models.product'))
  end
end

