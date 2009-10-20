# == Schema Information
#
# Table name: stories
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  estimative  :integer
#  priority    :integer
#  product_id  :integer
#  created_at  :datetime
#  updated_at  :datetime
#  color       :string(255)
#

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Story do
  before(:each) do
    @story = Factory.create(:story)
  end

  it 'should be valid' do
    @story.should be_valid
  end

  it { should have_db_columns :id, :name, :description, :estimative, :priority, :product_id, :color, :created_at, :updated_at, :creator_id, :updater_id }
  it { should validate_presence_of(:product_id) }
  it { should validate_length_of(:name, :within => 1..200) }
  it { should belong_to :creator }
  it { should belong_to :updater }
  it { should belong_to :product }
  it { should have_many :taskks, :dependent => :destroy }
  it { should validate_numericality_of :estimative, :priority }
end

