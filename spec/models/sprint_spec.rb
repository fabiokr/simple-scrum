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
#  creator_id         :integer
#  updater_id         :integer
#

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Sprint do
  before(:each) do
    @sprint = Factory.create(:sprint)
  end

  it "should be valid" do
    @sprint.should be_valid
  end

  it { should have_db_columns :id, :name, :start, :end, :velocity, :estimated_velocity, :product_id, :created_at, :updated_at, :creator_id, :updater_id }
  it { should validate_presence_of(:product_id) }
  it { should validate_length_of(:name, :within => 1..60) }
  it { should belong_to :creator }
  it { should belong_to :updater }
  it { should belong_to :product }
  it { should have_many :tickets }
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

    @sprint.end = 10.days.since.to_date
    @sprint.save

    @sprint.errors.invalid?(:start).should be_false
    @sprint.errors.invalid?(:end).should be_false
  end

  it "should have at least one work day between start and end" do
    @sprint.start = Date.civil(2009,10,9)
    @sprint.end = Date.civil(2009,10,10)

    @sprint.save

    @sprint.errors.invalid?(:start).should be_false
    @sprint.errors.invalid?(:end).should be_true
  end

  it "should set velocity and estimated_velocity to 0 if nil" do
    @sprint.velocity = nil
    @sprint.estimated_velocity = nil
    @sprint.save!

    @sprint.velocity.should == 0
    @sprint.estimated_velocity.should == 0
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

  it 'should plot burndown' do
    #expects 22 weekdays
    @sprint.start = Date.civil(2009,9,15)
    @sprint.end = Date.civil(2009,10,15)
    @sprint.save!

    ticket1 = Factory(:ticket, :product => @sprint.product, :sprint => @sprint, :estimative => 5, :status => Ticket::DONE)
    ticket2 = Factory(:ticket, :product => @sprint.product, :sprint => @sprint, :estimative => 8, :status => Ticket::DONE)
    ticket3 = Factory(:ticket, :product => @sprint.product, :sprint => @sprint, :estimative => 10, :status => Ticket::DONE)
    ticket4 = Factory(:ticket, :product => @sprint.product, :sprint => @sprint, :estimative => 7, :status => Ticket::DONE)

    ticket1.status_changed_at = Date.civil(2009,9,18)
    ticket2.status_changed_at = Date.civil(2009,9,25)
    ticket3.status_changed_at = Date.civil(2009,10,5)
    ticket4.status_changed_at = Date.civil(2009,10,5)

    ticket1.save!
    ticket2.save!
    ticket3.save!
    ticket4.save!

    @sprint.reload

    Date.stub!(:current).and_return(Date.civil(2009,10,7))

    plot = @sprint.burndown_plot

    date_format = "%e/%m"

    plot[:expected][:x].should == [0, 100]
    plot[:expected][:y].should == [100, 0]

    plot[:current][:x].should == [BigDecimal.new("0.0"), BigDecimal.new("4.3"), BigDecimal.new("8.6"), BigDecimal.new("12.9"), BigDecimal.new("17.2"), BigDecimal.new("21.5"), BigDecimal.new("25.8"), BigDecimal.new("30.1"), BigDecimal.new("34.4"), BigDecimal.new("38.7"), BigDecimal.new("43.0"), BigDecimal.new("47.3"), BigDecimal.new("51.6"), BigDecimal.new("55.9"), BigDecimal.new("60.2"), BigDecimal.new("64.5"), BigDecimal.new("68.8")]
    plot[:current][:y].should == [BigDecimal.new("99.0"), BigDecimal.new("99.0"), BigDecimal.new("99.0"), BigDecimal.new("82.5"), BigDecimal.new("82.5"), BigDecimal.new("82.5"), BigDecimal.new("82.5"), BigDecimal.new("82.5"), BigDecimal.new("56.1"), BigDecimal.new("56.1"), BigDecimal.new("56.1"), BigDecimal.new("56.1"), BigDecimal.new("56.1"), BigDecimal.new("56.1"), BigDecimal.new("0.0"), BigDecimal.new("0.0"), BigDecimal.new("0.0")]

    expected_dates = [Date.civil(2009,9,15),Date.civil(2009,9,17),Date.civil(2009,9,21),Date.civil(2009,9,23),Date.civil(2009,9,25),Date.civil(2009,9,29),Date.civil(2009,10,1),Date.civil(2009,10,5),Date.civil(2009,10,7),Date.civil(2009,10,9),Date.civil(2009,10,13),Date.civil(2009,10,15)]
    expected_dates.collect! {|date| date.strftime(date_format)}

    plot[:labels][:x].should == expected_dates

    #should distribute the labels
    plot[:labels][:y].should == [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30]
  end

  it "should plot future burndowns correctly" do
    #expects 22 weekdays
    @sprint.start = Date.civil(2009,9,15)
    @sprint.end = Date.civil(2009,9,28)
    @sprint.save!

    ticket1 = Factory(:ticket, :product => @sprint.product, :sprint => @sprint, :estimative => 14, :status => Ticket::TODO)
    ticket2 = Factory(:ticket, :product => @sprint.product, :sprint => @sprint, :estimative => 16, :status => Ticket::TODO)

    @sprint.reload

    Date.stub!(:current).and_return(Date.civil(2009,8,7))

    plot = @sprint.burndown_plot

    date_format = "%e/%m"

    plot[:expected][:x].should == [0, 100]
    plot[:expected][:y].should == [100, 0]

    plot[:current].should_not be_nil
    plot[:current][:x].should == [0]
    plot[:current][:y].should == [0]

    #should distribute the labels
    expected_dates = [Date.civil(2009,9,15),Date.civil(2009,9,16),Date.civil(2009,9,17),Date.civil(2009,9,18),Date.civil(2009,9,21),Date.civil(2009,9,22),Date.civil(2009,9,23),Date.civil(2009,9,24),Date.civil(2009,9,25),Date.civil(2009,9,28)]
    expected_dates.collect! {|date| date.strftime(date_format)}

    plot[:labels][:x].should == expected_dates
    plot[:labels][:y].should == [0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30]
  end

end

