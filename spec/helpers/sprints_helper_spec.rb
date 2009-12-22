require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SprintsHelper, 'sprint backlog' do

  before :each do
    @product = Factory(:product)
    @story = Factory(:story, :product => @product)
    @sprint = Factory(:sprint, :product => @product)

    @todo = Factory(:task, :story => @story, :sprint => @sprint, :status => Task::STATUS[0])
    @doing = Factory(:task, :story => @story, :sprint => @sprint, :status => Task::STATUS[1])
    @done = Factory(:task, :story => @story, :sprint => @sprint, :status => Task::STATUS[2])

    @sprint.reload
    @story.reload
    @product.reload

    class << helper; self; end
  end

  it "should be included in the object returned by #helper" do
    included_modules = (class << helper; self; end).send :included_modules
    included_modules.should include(SprintsHelper)
  end

end

