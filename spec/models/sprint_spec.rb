# == Schema Information
#
# Table name: sprints
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  velocity   :float
#  start      :date
#  end        :date
#  product_id :integer
#  created_at :datetime
#  updated_at :datetime
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
end

