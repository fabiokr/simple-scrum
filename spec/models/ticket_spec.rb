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

describe Ticket do
  before(:each) do
    @ticket = Factory.create(:ticket)
  end

  it 'should be valid' do
    @ticket.should be_valid
  end

  it { should have_db_columns :id, :category_id, :name, :description, :estimative, :priority, :product_id, :unplanned, :status, :status_changed_at, :created_at, :updated_at, :creator_id, :updater_id }
  it { should validate_presence_of(:product_id, :category_id) }
  it { should validate_length_of(:name, :within => 1..200) }
  it { should belong_to :creator }
  it { should belong_to :updater }
  it { should belong_to :product }
  it { should belong_to :sprint }
  it { should validate_numericality_of :estimative, :priority }
  it { should validate_inclusion_of(:status, :in => Ticket::STATUS) }
  it { should validate_inclusion_of(:category_id, :in => Ticket::CATEGORY) }

  it "should return valid status_str" do
    @ticket.status = Ticket::TODO
    @ticket.status_str.should == 'todo'

    @ticket.status = Ticket::DOING
    @ticket.status_str.should == 'doing'

    @ticket.status = Ticket::DONE
    @ticket.status_str.should == 'done'
  end

  it "should return valid category_str" do
    @ticket.category_id = Ticket::STORY
    @ticket.category_str.should == 'story'

    @ticket.category_id = Ticket::BUG
    @ticket.category_str.should == 'bug'

    @ticket.category_id = Ticket::CHANGE
    @ticket.category_str.should == 'change'
  end

  it 'should set status to "not_started" before save if not status is not defined' do
    ticket = Factory.build(:ticket, :id => nil, :status => nil)
    ticket.save!
    assert_equal Ticket::TODO, ticket.status

    ticket = Factory.build(:ticket, :id => nil, :status => Ticket::DONE)
    ticket.save!
    assert_equal Ticket::DONE, ticket.status

    ticket = Factory(:ticket, :status => nil)
    ticket.save!
    assert_equal Ticket::TODO, ticket.status

    ticket = Factory(:ticket, :status => Ticket::DOING)
    ticket.save!
    assert_equal Ticket::DOING, ticket.status
  end

end

