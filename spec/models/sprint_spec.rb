# == Schema Information
#
# Table name: sprints
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  estimated_velocity :integer
#  velocity           :integer
#  start              :date
#  end                :date
#  product_id         :integer
#  created_at         :datetime
#  updated_at         :datetime
#

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Sprint do
  before(:each) do
    @sprint = Factory.create(:sprint)
  end

  it "should be valid" do
    @sprint.should be_valid
  end

  it { should have_db_columns :id, :name, :start, :end, :velocity, :estimated_velocity, :product_id, :created_at, :updated_at }
  it { should validate_presence_of(:product_id) }
  it { should validate_length_of(:name, :within => 1..60) }
  it { should belong_to :product }
  it { should have_many :tasks }
  it { should validate_numericality_of :velocity, :estimated_velocity }

  it "should verify if end date is after start date" do
    @sprint.start = nil
    @sprint.end = nil
    @sprint.save

    @sprint.errors.invalid?(:start).should be_false
    @sprint.errors.invalid?(:end).should be_false

    @sprint.start = Date.current
    @sprint.end = Date.current
    @sprint.save

    @sprint.errors.invalid?(:start).should be_false
    @sprint.errors.invalid?(:end).should be_true

    @sprint.end = 1.day.ago
    @sprint.save

    @sprint.errors.invalid?(:start).should be_false
    @sprint.errors.invalid?(:end).should be_true

    @sprint.end = 1.day.since
    @sprint.save

    @sprint.errors.invalid?(:start).should be_false
    @sprint.errors.invalid?(:end).should be_false
  end

  it "should set velocity and estimated_velocity to 0 if nil" do
    @sprint.velocity = nil
    @sprint.estimated_velocity = nil
    @sprint.save!

    @sprint.velocity.should == 0
    @sprint.estimated_velocity.should == 0
  end

  it "should group by story" do
    @product = Factory(:product)
    @story = Factory(:story, :product => @product)
    @sprint = Factory(:sprint, :product => @product)

    @todo = Factory(:task, :story => @story, :sprint => @sprint, :status => Taskk::STATUS[0])
    @doing = Factory(:task, :story => @story, :sprint => @sprint, :status => Taskk::STATUS[1])
    @done = Factory(:task, :story => @story, :sprint => @sprint, :status => Taskk::STATUS[2])

    @sprint.reload
    @story.reload
    @product.reload

    stories = @sprint.group_tasks_by_story

    stories.should include(@story)
    stories[@story].should include(@todo, @doing, @done)
  end

  it "should plot empty burndown where there is no data" do
    @sprint.start = nil
    @sprint.end = nil
    @sprint.save!

    plot = @sprint.burndown_plot

    plot[:expected][:x].should be_empty
    plot[:expected][:y].should be_empty
    plot[:current][:x].should be_empty
    plot[:current][:y].should be_empty
    plot[:labels][:x].should be_empty
    plot[:labels][:y].should be_empty
  end

  it "should plot burndown correctly" do
    #expects 22 weekdays
    @sprint.start = Date.civil(2009,9,15)
    @sprint.end = Date.civil(2009,10,15)
    @sprint.save!

    story1 = Factory(:story, :product => @sprint.product, :estimative => 14)
    story2 = Factory(:story, :product => @sprint.product, :estimative => 16)

    task1 = Factory(:task, :story => story1, :sprint => @sprint, :status => Taskk::DONE)
    task1.status_changed_at = Date.civil(2009,9,18)
    task1.save!
    @sprint.reload
    task2 = Factory(:task, :story => story1, :sprint => @sprint, :status => Taskk::DONE)
    task2.status_changed_at = Date.civil(2009,9,25)
    task2.save!
    @sprint.reload

    task3 = Factory(:task, :story => story2, :sprint => @sprint, :status => Taskk::DONE)
    task3.status_changed_at = Date.civil(2009,10,5)
    task3.save!
    @sprint.reload
    task4 = Factory(:task, :story => story2, :sprint => @sprint, :status => Taskk::DONE)
    task4.status_changed_at = Date.civil(2009,10,5)
    task4.save!
    @sprint.reload

    Date.stub!(:current).and_return(Date.civil(2009,10,7))

    plot = @sprint.burndown_plot

    date_format = "%d/%m"

    plot[:expected][:x].should == [0, 22]
    plot[:expected][:y].should == [30, 0]

    plot[:current].should_not be_nil
    plot[:current][:x].should == (0..16).to_a
    plot[:current][:y].should == [30, 30, 30, 30, 30, 30, 30, 30, 16, 16, 16, 16, 16, 16, 0, 0, 0]

    expected_dates = [Date.civil(2009,9,15),Date.civil(2009,9,16),Date.civil(2009,9,17),Date.civil(2009,9,18),Date.civil(2009,9,21),Date.civil(2009,9,22),Date.civil(2009,9,23),Date.civil(2009,9,24),Date.civil(2009,9,25),Date.civil(2009,9,28),Date.civil(2009,9,29),Date.civil(2009,9,30),Date.civil(2009,10,1),Date.civil(2009,10,2),Date.civil(2009,10,5),Date.civil(2009,10,6),Date.civil(2009,10,7),Date.civil(2009,10,8),Date.civil(2009,10,9),Date.civil(2009,10,12),Date.civil(2009,10,13),Date.civil(2009,10,14),Date.civil(2009,10,15)]
    expected_dates_labels = []
    expected_dates.each {|date| expected_dates_labels << date.strftime(date_format)}

    plot[:labels][:x].should == expected_dates_labels
    plot[:labels][:y].should == (0..30).to_a
  end
end

