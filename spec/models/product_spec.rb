require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Product do
  before(:each) do
    @product = Factory.create(:product)
  end

  it 'should be valid' do
    @product.should be_valid
  end

  it { should validate_length_of(:name, :within => 1..60) }
  it { should validate_length_of(:owner, :within => 1..60) }
  it { should have_many :stories }
  it { should have_many :sprints }
end

