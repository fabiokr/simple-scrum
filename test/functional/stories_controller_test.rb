require 'test_helper'

class StoriesControllerTest < ActionController::TestCase
    context 'on GET to :index' do
      setup do
        @stories = [Factory(:story), Factory(:story)]
        get :index, :product_id => @stories.first.product.id
      end

      should_respond_with :success
      should_assign_to(:product) {@stories.first.product}
      should_assign_to(:stories)
      should 'assign stories' do
        assert_equal 1, assigns(:stories).size
        assert_equal @stories.first, assigns(:stories).first
      end
    end

    context "on GET to :show" do
      setup do
        @story = Factory(:story)
        get :show, :product_id => @story.product.id, :id => @story.id
      end

      should_respond_with :success
      should_assign_to(:story) {@story}
      should_assign_to(:product) {@story.product}
    end

    context "on GET to :new" do
      setup do
        @product = Factory(:product)
        get :new, :product_id => @product
      end

      should_respond_with :success
      should_assign_to(:product) {@product}
      should_assign_to :story
      should 'set story product' do
        assert_equal @product, assigns(:story).product
      end
    end

    context "on POST to :create" do
      setup do
        @story = Factory.build(:story)
        @product = Factory(:product)
        post :create, :product_id => @product.id, :story => @story.attributes
      end

      should_redirect_to('show') { product_stories_path(@product) }
      should_set_the_flash_to /.*/
      should 'create story' do
        assert_equal 1, Story.count
        assert_equal @product, Story.all.first.product
      end
    end

    context "on POST as xhr to :create" do
      setup do
        @story = Factory.build(:story)
        @product = Factory(:product)
        xhr :post, :create, {:product_id => @product.id, :story => @story.attributes}
      end

      should_respond_with :success
      should_assign_to(:product) {@product}
      should_assign_to :stories
      should 'create story' do
        assert_equal 1, Story.count
        assert_equal @product, Story.all.first.product
      end
    end

    context "on POST to :create with invalid records" do
      setup do
        @story = Story.new
        @product = Factory(:product)
        post :create, :product_id => @product.id, :story => @story.attributes
      end

      should_render_template :new
      should 'not create story' do
        assert_equal 0, Story.count
      end
    end

    context "on GET to :edit" do
      setup do
        @story = Factory(:story)
        get :edit, :product_id => @story.product.id, :id => @story.id
      end

      should_respond_with :success
      should_assign_to(:story) {@story}
      should_assign_to(:product) {@story.product}
    end

    context "on POST to :update" do
      setup do
        @story = Factory(:story)
        post :update, :product_id => @story.product.id, :id => @story.id, :story => {:name => 'New name'}
      end

      should_redirect_to('show') {product_stories_path(@story.product)}
      should_set_the_flash_to /.*/
      should 'update story' do
        assert_equal 'New name', Story.find(@story.id).name
      end
    end

    context "on POST as xhr to :update" do
      setup do
        @story = Factory(:story)
        xhr :post, :update, {:product_id => @story.product.id, :id => @story.id, :story => {:name => 'New name'}}
      end

      should_respond_with :success
      should_assign_to(:product) {@product}
      should_assign_to :stories
      should 'update story' do
        assert_equal 'New name', Story.find(@story.id).name
      end
    end

    context "on POST to :update with invalid records" do
      setup do
        @story = Factory(:story)
        @story_invalid = Story.new
        post :update, :product_id => @story.product.id, :id => @story.id, :story => @story_invalid.attributes
      end

      should_render_template :edit
      should 'not update story' do
        assert_not_equal '', Story.find(@story.id).name
      end
    end

    context "on DELETE to :destroy" do
      setup do
        @story = Factory(:story)
        delete :destroy, :product_id => @story.product.id, :id => @story.id
      end

      should_redirect_to('index') {product_stories_path(@story.product)}
      should_set_the_flash_to /.*/
      should 'destroy story' do
        assert_equal 0, Story.count
      end
    end

    context "on DELETE as xhr to :destroy" do
      setup do
        @story = Factory(:story)
        xhr :delete, :destroy, {:product_id => @story.product.id, :id => @story.id}
      end

      should_respond_with :success
      should_assign_to(:product) {@product}
      should_assign_to :stories
      should 'destroy story' do
        assert_equal 0, Story.count
      end
    end
end

