require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StoriesController, 'routes' do
  should_route :get, '/products/1/stories', :controller => :stories, :action => :index, :product_id => 1
  should_route :get, '/products/1/stories/1', :controller => :stories, :action => :show, :id => 1, :product_id => 1
  should_route :get, '/products/1/stories/new', :controller => :stories, :action => :new, :product_id => 1
  should_route :get, '/products/1/stories/1/edit', :controller => :stories, :action => :edit, :id => 1, :product_id => 1
  should_route :post, '/products/1/stories', :controller => :stories, :action => :create, :product_id => 1
  should_route :put, '/products/1/stories/1', :controller => :stories, :action => :update, :id => 1, :product_id => 1
  should_route :delete, '/products/1/stories/1', :controller => :stories, :action => :destroy, :id => 1, :product_id => 1
end

describe StoriesController do

  integrate_views

  before :each do
    @product = Factory(:product)
    @story = Factory(:story, :product => @product)
    @user = Factory(:user)
    activate_authlogic
    UserSession.create(@user)
  end

  after :each do
    assigns(:product).should_not be_nil unless assigns(:current_user_session).nil?
  end

  it "should require user" do
    UserSession.find.destroy

    get :index, :product_id => @product.id
    response.should redirect_to(new_session_path)

    get :show, :product_id => @product.id, :id => @story.id
    response.should redirect_to(new_session_path)

    get :new, :product_id => @product.id
    response.should redirect_to(new_session_path)

    get :edit, :product_id => @product.id, :id => @story.id
    response.should redirect_to(new_session_path)

    story = Factory.build(:story)
    post :create, :product_id => @product.id, :story => story.attributes
    response.should redirect_to(new_session_path)

    @story.name = 'new name'
    post :update, :product_id => @product.id, :id => @story.id, :story => @story.attributes
    response.should redirect_to(new_session_path)

    get :destroy, :product_id => @product.id, :id => @story.id
    response.should redirect_to(new_session_path)
  end

  it "should user stamp the story on create and update" do
    story = Factory.build(:story)
    post :create, :product_id => @product.id, :story => story.attributes
    assigns(:story).creator_id.should == @user.id
    assigns(:story).updater_id.should == @user.id

    user = Factory(:user)
    story = Factory(:story, :product => @product, :creator => user, :updater => user)

    post :update, :product_id => @product.id, :id => story.id, :story => {:name => 'new name'}
    assigns(:story).creator_id.should == user.id
    assigns(:story).updater_id.should == @user.id
  end

  it "should list stories on :index" do
    get :index, :product_id => @product.id

    assigns(:search).should_not be_nil
    assigns(:stories).should include(@story)
  end

  it "should assign story on :show" do
    get :show, :product_id => @product.id, :id => @story.id

    assigns(:story).should == @story
  end

  it "should assign a new story on :new" do
    get :new, :product_id => @product.id

    assigns(:story).should be_new_record
  end

  it "should assign story on :edit" do
    get :edit, :product_id => @product.id, :id => @story.id

    assigns(:story).should == @story
  end

  it "should add new story on :create" do
    @story = Factory.build(:story)
    post :create, :product_id => @product.id, :story => @story.attributes

    assigns(:story).should == Story.find(assigns(:story).id)
    response.should redirect_to(product_stories_path(@product))
    flash[:message].should_not be_nil
  end

  it "should add new story on :create and render reload_index if format is js" do
    @story = Factory.build(:story)
    post :create, :product_id => @product.id, :story => @story.attributes, :format => 'js'

    assigns(:story).should == Story.find(assigns(:story).id)
    response.should render_template('reload_index')
    flash[:message].should_not be_nil
  end

  it "should re-render new when invalid on :create" do
    @story = Factory.build(:story, :name => nil)
    post :create, :product_id => @product.id, :story => @story.attributes

    response.should render_template('new')
  end

  it "should save story on :update" do
    @story.name = 'new name'
    post :update, :product_id => @product.id, :id => @story.id, :story => @story.attributes

    Story.find(assigns(:story).id).name.should == @story.name
    response.should redirect_to(product_stories_path(@product))
    flash[:message].should_not be_nil
  end

  it "should save story on :update and render reload_index if format is js" do
    @story.name = 'new name'
    post :update, :product_id => @product.id, :id => @story.id, :story => @story.attributes, :format => 'js'

    Story.find(assigns(:story).id).name.should == @story.name
    response.should render_template('reload_index')
    flash[:message].should_not be_nil
  end

  it "should re-render edit when invalid on :update" do
    @story.name = nil
    post :update, :product_id => @product.id, :id => @story.id, :story => @story.attributes

    response.should render_template('edit')
  end

  it "should delete story on :destroy" do
    get :destroy, :product_id => @product.id, :id => @story.id

    lambda { Story.find(@story.id) }.should raise_error
    response.should redirect_to(product_stories_path(@product))
    flash[:message].should_not be_nil
  end

end

