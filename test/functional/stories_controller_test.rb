require 'test_helper'

class StoriesControllerTest < ActionController::TestCase

  context 'on GET to :index' do
    setup do
      @product = Factory(:product)
      @products = [@product, Factory(:product)].paginate
      @stories = [Factory(:story), Factory(:story)].paginate

      Product.expects(:find => @product, :all => @products)
      @product.expects(:stories => @stories)

      get :index, :product_id => @product.id
    end

    should_respond_with :success
    should_assign_to(:stories) {@stories}
    should_assign_to(:product) {@product}
  end
end

