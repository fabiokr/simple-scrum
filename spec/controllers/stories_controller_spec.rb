require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

def prepare_product_and_stories
  @product = Factory.build(:product)
  Product.should_receive(:find).with(@product.id.to_s).and_return(@product)
  @stories = [Factory.build(:story, :product => @product)]
  @story = @stories.first
  @product.should_receive(:stories).and_return(@stories)
end

describe SprintsController do
  should_route :get, '/products/1/stories', :controller => :stories, :action => :index, :product_id => 1
  should_route :get, '/products/1/stories/1', :controller => :stories, :action => :show, :id => 1, :product_id => 1
  should_route :get, '/products/1/stories/new', :controller => :stories, :action => :new, :product_id => 1
  should_route :get, '/products/1/stories/1/edit', :controller => :stories, :action => :edit, :id => 1, :product_id => 1
  should_route :post, '/products/1/stories', :controller => :stories, :action => :create, :product_id => 1
  should_route :put, '/products/1/stories/1', :controller => :stories, :action => :update, :id => 1, :product_id => 1
  should_route :delete, '/products/1/stories/1', :controller => :stories, :action => :destroy, :id => 1, :product_id => 1
end

describe StoriesController, 'on index' do

  integrate_views

  it "should list a product stories" do
    @stories = [Factory(:story), Factory(:story)]

    get :index, :product_id => @stories.first.product.id

    assigns(:product)
    assert_equal 1, assigns(:stories).count
  end

end

describe StoriesController, 'on show' do

  integrate_views

  it "should show product story" do
    prepare_product_and_stories
    @stories.should_receive(:find).with(@story.id.to_s).and_return(@story)

    get :show, :product_id => @product.id, :id => @story.id

    assert_equal @product, assigns(:product)
    assert_equal @story, assigns(:story)
  end

end

describe StoriesController, 'on new' do

  integrate_views

  it "should edit new product story" do
    prepare_product_and_stories
    @stories.should_receive(:new).and_return(@story)

    get :new, :product_id => @product.id

    assert_equal @product, assigns(:product)
    assert_equal @story, assigns(:story)
  end

end

describe StoriesController, 'on edit' do

  integrate_views

  it "should edit existing product story" do
    prepare_product_and_stories
    @stories.should_receive(:find).with(@story.id.to_s).and_return(@story)

    get :edit, :product_id => @product.id, :id => @story.id

    assert_equal @product, assigns(:product)
    assert_equal @story, assigns(:story)
  end

end

describe StoriesController, 'on create' do

  integrate_views

  before(:each) do
    prepare_product_and_stories
    @stories.should_receive(:new).with(@story.attributes).and_return(@story)
  end

  it "should redirect to index with notice when valid" do
    @story.should_receive(:save).and_return(true)

    post :create, :product_id => @product.id, :story => @story.attributes

    assert_equal @story, assigns(:story)
    flash[:message].should_not be_nil
    response.should redirect_to(product_stories_path(@product))
  end

  it "should re-render new when invalid" do
    @story.should_receive(:save).and_return(false)

    post :create, :product_id => @product.id, :story => @story.attributes

    assert_equal @product, assigns(:product)
    response.should render_template('new')
  end

end

describe StoriesController, 'on update' do

  integrate_views

  before(:each) do
    prepare_product_and_stories
    @stories.should_receive(:find).with(@story.id.to_s).and_return(@story)
  end

  it "should redirect to index with notice when valid" do
    @story.should_receive(:update_attributes).and_return(true)

    post :update, :product_id => @product.id, :id => @story.id, :story => @story.attributes

    assert_equal @story, assigns(:story)
    flash[:message].should_not be_nil
    response.should redirect_to(product_stories_path(@product))
  end

  it "should re-render new when invalid" do
    @story.should_receive(:update_attributes).and_return(false)

    post :update, :product_id => @product.id, :id => @story.id, :story => @story.attributes

    assert_equal @product, assigns(:product)
    response.should render_template('edit')
  end

end

describe StoriesController, 'on destroy' do

  integrate_views

  it "should redirect to index" do
    prepare_product_and_stories
    @stories.should_receive(:find).with(@story.id.to_s).and_return(@story)
    @story.should_receive(:destroy).and_return(true)

    get :destroy, :product_id => @product.id, :id => @story.id

    flash[:message].should_not be_nil
    response.should redirect_to(product_stories_path(@product))
  end

end

