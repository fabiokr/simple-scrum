require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Story do
  before(:each) do
    @story = Factory.create(:story)
  end

  it 'should be valid' do
    @story.should be_valid
  end

  it { should have_db_columns :id, :name, :description, :estimative, :priority, :product_id, :created_at, :updated_at }
  it { should validate_presence_of(:product_id) }
  it { should validate_length_of(:name, :within => 1..200) }
  it { should belong_to :product }
  it { should validate_numericality_of :estimative, :priority }
end

