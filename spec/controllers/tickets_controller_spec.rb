require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe TicketsController, 'routes' do
  should_route :get, '/products/1/tickets', :controller => :tickets, :action => :index, :product_id => 1
  should_route :get, '/products/1/tickets/1', :controller => :tickets, :action => :show, :id => 1, :product_id => 1
  should_route :get, '/products/1/tickets/new', :controller => :tickets, :action => :new, :product_id => 1
  should_route :get, '/products/1/tickets/1/edit', :controller => :tickets, :action => :edit, :id => 1, :product_id => 1
  should_route :post, '/products/1/tickets', :controller => :tickets, :action => :create, :product_id => 1
  should_route :put, '/products/1/tickets/1', :controller => :tickets, :action => :update, :id => 1, :product_id => 1
  should_route :delete, '/products/1/tickets/1', :controller => :tickets, :action => :destroy, :id => 1, :product_id => 1
end

describe TicketsController do

  integrate_views

  before :each do
    @product = Factory(:product)
    @ticket = Factory(:ticket, :product => @product)
    @user = Factory(:user)
    activate_authlogic
    UserSession.create(@user)
  end

  after :each do
    assigns(:product).should_not be_nil unless assigns(:current_user_session).nil?
  end

  it "should require user" do
    UserSession.find.destroy

    get :index, :product_id => @product.slug
    response.should redirect_to(new_session_path)

    get :show, :product_id => @product.slug, :id => @ticket.id
    response.should redirect_to(new_session_path)

    get :new, :product_id => @product.slug
    response.should redirect_to(new_session_path)

    get :edit, :product_id => @product.slug, :id => @ticket.id
    response.should redirect_to(new_session_path)

    ticket = Factory.build(:ticket)
    post :create, :product_id => @product.slug, :ticket => ticket.attributes
    response.should redirect_to(new_session_path)

    @ticket.name = 'new name'
    post :update, :product_id => @product.slug, :id => @ticket.id, :ticket => @ticket.attributes
    response.should redirect_to(new_session_path)

    get :destroy, :product_id => @product.slug, :id => @ticket.id
    response.should redirect_to(new_session_path)
  end

  it "should user stamp the ticket on create and update" do
    ticket = Factory.build(:ticket)
    post :create, :product_id => @product.slug, :ticket => ticket.attributes
    assigns(:ticket).creator_id.should == @user.id
    assigns(:ticket).updater_id.should == @user.id

    user = Factory(:user)
    ticket = Factory(:ticket, :product => @product, :creator => user, :updater => user)

    post :update, :product_id => @product.slug, :id => ticket.id, :ticket => {:name => 'new name'}
    assigns(:ticket).creator_id.should == user.id
    assigns(:ticket).updater_id.should == @user.id
  end

  it "should list tickets on :index" do
    get :index, :product_id => @product.slug

    assigns(:search).should_not be_nil
    assigns(:tickets).should include(@ticket)
  end

  it "should assign ticket on :show" do
    get :show, :product_id => @product.slug, :id => @ticket.id

    assigns(:ticket).should == @ticket
  end

  it "should assign a new ticket on :new" do
    get :new, :product_id => @product.slug

    assigns(:ticket).should be_new_record
  end

  it "should assign ticket on :edit" do
    get :edit, :product_id => @product.slug, :id => @ticket.id

    assigns(:ticket).should == @ticket
  end

  it "should add new ticket on :create" do
    @ticket = Factory.build(:ticket)
    post :create, :product_id => @product.slug, :ticket => @ticket.attributes

    assigns(:ticket).should == Ticket.find(assigns(:ticket).id)
    response.should redirect_to(edit_product_ticket_path(@product.slug, assigns(:ticket)))
    flash[:message].should_not be_nil
  end

  it "should re-render new when invalid on :create" do
    @ticket = Factory.build(:ticket, :name => nil)
    post :create, :product_id => @product.slug, :ticket => @ticket.attributes

    response.should render_template('new')
  end

  it "should save ticket on :update" do
    @ticket.name = 'new name'
    post :update, :product_id => @product.slug, :id => @ticket.id, :ticket => @ticket.attributes

    Ticket.find(assigns(:ticket).id).name.should == @ticket.name
    response.should redirect_to(edit_product_ticket_path(@product.slug, @ticket))
    flash[:message].should_not be_nil
  end

  it "should re-render edit when invalid on :update" do
    @ticket.name = nil
    post :update, :product_id => @product.slug, :id => @ticket.id, :ticket => @ticket.attributes

    response.should render_template('edit')
  end

  it "should delete ticket on :destroy" do
    get :destroy, :product_id => @product.slug, :id => @ticket.id

    lambda { Ticket.find(@ticket.id) }.should raise_error
    response.should redirect_to(product_tickets_path(@product.slug))
    flash[:message].should_not be_nil
  end

  it "should delete ticket on :destroy and set header to ok if xhr" do
    xhr 'get', :destroy, :product_id => @product.slug, :id => @ticket.id

    lambda { Ticket.find(@ticket.id) }.should raise_error
    response.should_not render_template
  end

end

