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
  it { should have_many :stories }
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

end

