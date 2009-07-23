require 'test_helper'

class StoriesControllerTest < ActionController::TestCase

  context 'A request' do
    setup do
      @product = Factory(:product)
      #expectation for views that uses Product.all to list all products
      @products = [@product, Factory(:product)].paginate
      Product.expects(:find => @product, :all => @products)
    end

    context 'on GET to :index' do
      setup do
        @stories = [Factory(:story), Factory(:story)].paginate
        @product.expects(:stories => @stories)
        @search = Story.search
        @stories.expects(:search => @search)
        @search.expects(:all => @stories)

        get :index, :product_id => @product.id
      end

      should_respond_with :success
      should_assign_to(:stories) {@stories}
      should_assign_to(:product) {@product}
    end
  end
end

