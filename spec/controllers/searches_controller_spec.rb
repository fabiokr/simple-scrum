require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ProductsController, 'routes' do
  should_route :get, '/search', :controller => :searches, :action => :show
end

describe SearchesController do

  integrate_views

  before :each do
    @product1 = Factory(:product, :name => 'a great product', :owner => 'first owner')
    @product2 = Factory(:product, :name => 'another worderful product', :owner => 'second owner')
    @story1 = Factory(:story, :product => @product1, :name => 'good story', :description => 'really good')
    @story2 = Factory(:story, :product => @product2, :name => 'great story', :description => 'really wonderful')
    @sprint1 = Factory(:sprint, :product => @product1, :name => 'this sprint')
    @sprint2 = Factory(:sprint, :product => @product2, :name => 'other sprint')
    @task1 = Factory(:task, :story => @story1, :sprint => @sprint1, :name => 'good task', :description => 'really good')
    @task2 = Factory(:task, :story => @story2, :sprint => @sprint2, :name => 'great task', :description => 'really wonderful')
  end

  it "should do no search if query has less than 3 chars" do
    get :show, :q => 'gr'
    assigns(:products).should == []
    assigns(:stories).should == []
    assigns(:sprints).should == []
    assigns(:tasks).should == []
    flash[:notice].should_not be_nil

    get :show, :q => 'g'
    assigns(:products).should == []
    assigns(:stories).should == []
    assigns(:sprints).should == []
    assigns(:tasks).should == []
    flash[:notice].should_not be_nil

    get :show, :q => ''
    assigns(:products).should == []
    assigns(:stories).should == []
    assigns(:sprints).should == []
    assigns(:tasks).should == []
    flash[:notice].should_not be_nil
  end

  it "should look for products by name and owner" do
    get :show, :q => 'great'
    assigns(:products).should == [@product1]

    get :show, :q => 'second'
    assigns(:products).should == [@product2]
  end

  it "should look for story by name and description" do
    get :show, :q => 'good'
    assigns(:stories).should == [@story1]

    get :show, :q => 'wonderful'
    assigns(:stories).should == [@story2]
  end

  it "should look for sprint by name" do
    get :show, :q => 'this'
    assigns(:sprints).should == [@sprint1]

    get :show, :q => 'other'
    assigns(:sprints).should == [@sprint2]
  end

  it "should look for task by name and description" do
    get :show, :q => 'good'
    assigns(:tasks).should == [@task1]

    get :show, :q => 'wonderful'
    assigns(:tasks).should == [@task2]
  end

end

