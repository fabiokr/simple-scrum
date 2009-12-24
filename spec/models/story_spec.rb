# == Schema Information
#
# Table name: stories
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  color       :string(255)
#  description :text
#  estimative  :integer
#  priority    :integer
#  product_id  :integer
#  created_at  :datetime
#  updated_at  :datetime
#  creator_id  :integer
#  updater_id  :integer
#

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Story do
  before(:each) do
    @story = Factory.create(:story)
  end

  it 'should be valid' do
    @story.should be_valid
  end

  it { should have_db_columns :id, :name, :description, :estimative, :priority, :product_id, :color, :unplanned, :status, :status_changed_at, :created_at, :updated_at, :creator_id, :updater_id }
  it { should validate_presence_of(:product_id) }
  it { should validate_length_of(:name, :within => 1..200) }
  it { should belong_to :creator }
  it { should belong_to :updater }
  it { should belong_to :product }
  it { should belong_to :sprint }
  it { should validate_numericality_of :estimative, :priority }
  it { should validate_inclusion_of(:status, :in => Story::STATUS) }

  it "should return valid status_str" do
    @story.status = Story::TODO
    @story.status_str.should == 'todo'

    @story.status = Story::DOING
    @story.status_str.should == 'doing'

    @story.status = Story::DONE
    @story.status_str.should == 'done'
  end

  it 'should set status to "not_started" before save if not status is not defined' do
    story = Factory.build(:story, :id => nil, :status => nil)
    story.save!
    assert_equal Story::TODO, story.status

    story = Factory.build(:story, :id => nil, :status => Story::DONE)
    story.save!
    assert_equal Story::DONE, story.status

    story = Factory(:story, :status => nil)
    story.save!
    assert_equal Story::TODO, story.status

    story = Factory(:story, :status => Story::DOING)
    story.save!
    assert_equal Story::DOING, story.status
  end

end

