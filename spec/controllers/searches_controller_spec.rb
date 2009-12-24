require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProductsController, 'routes' do
  should_route :get, '/search', :controller => :searches, :action => :show
end

describe SearchesController do

  integrate_views

  before :each do
    @product1 = Factory(:product, :name => 'a great product', :owner => 'first owner')
    @product2 = Factory(:product, :name => 'another worderful product', :owner => 'second owner')
    @ticket1 = Factory(:ticket, :product => @product1, :name => 'good ticket', :description => 'really good')
    @ticket2 = Factory(:ticket, :product => @product2, :name => 'great ticket', :description => 'really wonderful')
    @sprint1 = Factory(:sprint, :product => @product1, :name => 'this sprint')
    @sprint2 = Factory(:sprint, :product => @product2, :name => 'other sprint')

    @user = Factory(:user)
    activate_authlogic
    UserSession.create(@user)
  end

  it "should require user" do
    UserSession.find.destroy

    get :show
    response.should redirect_to(new_session_path)
  end

  it "should do no search if query has less than 3 chars" do
    get :show, :q => 'gr'
    assigns(:products).should == []
    assigns(:tickets).should == []
    assigns(:sprints).should == []
    flash[:notice].should_not be_nil

    get :show, :q => 'g'
    assigns(:products).should == []
    assigns(:tickets).should == []
    assigns(:sprints).should == []
    flash[:notice].should_not be_nil

    get :show, :q => ''
    assigns(:products).should == []
    assigns(:tickets).should == []
    assigns(:sprints).should == []
    flash[:notice].should_not be_nil
  end

  it "should look for products by name and owner" do
    get :show, :q => 'great'
    assigns(:products).should == [@product1]

    get :show, :q => 'second'
    assigns(:products).should == [@product2]
  end

  it "should look for ticket by name and description" do
    get :show, :q => 'good'
    assigns(:tickets).should == [@ticket1]

    get :show, :q => 'wonderful'
    assigns(:tickets).should == [@ticket2]
  end

  it "should look for sprint by name" do
    get :show, :q => 'this'
    assigns(:sprints).should == [@sprint1]

    get :show, :q => 'other'
    assigns(:sprints).should == [@sprint2]
  end

end

