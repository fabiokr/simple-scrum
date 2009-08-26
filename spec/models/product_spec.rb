require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Product do
  before(:each) do
    @product = Factory.create(:product)
  end

  it 'should be valid' do
    @product.should be_valid
  end

  it { should have_db_columns :id, :name, :owner, :created_at, :updated_at }
  it { should validate_length_of(:name, :owner, :within => 1..60) }
  it { should have_many :stories, :sprints }
end

