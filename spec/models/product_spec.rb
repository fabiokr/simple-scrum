# == Schema Information
#
# Table name: products
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  owner      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  creator_id :integer
#  updater_id :integer
#

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Product do
  before(:each) do
    @product = Factory.create(:product)
  end

  it 'should be valid' do
    @product.should be_valid
  end

  it { should have_db_columns :id, :name, :owner, :created_at, :updated_at, :creator_id, :updater_id }
  it { should validate_length_of(:name, :owner, :within => 1..60) }
  it { should belong_to :creator }
  it { should belong_to :updater }
  it { should have_many :stories, :dependent => :destroy }
  it { should have_many :sprints, :dependent => :destroy }
end

