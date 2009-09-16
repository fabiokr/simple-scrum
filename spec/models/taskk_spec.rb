# == Schema Information
#
# Table name: tasks
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  status      :string(255)
#  description :text
#  estimative  :integer
#  story_id    :integer
#  sprint_id   :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Taskk do
  before(:each) do
    @task = Factory.create(:task)
  end

  it 'should be valid' do
    @task.should be_valid
  end

  it { should have_db_columns :id, :name, :description, :estimative, :story_id, :sprint_id, :created_at, :updated_at }
  it { should belong_to :story }
  it { should belong_to :sprint }

  it { should validate_presence_of(:story, :sprint) }
  it { should validate_length_of(:name, :within => 1..200) }
  it { should validate_inclusion_of(:status, :in => Taskk::STATUS) }
  it { should validate_numericality_of :estimative }

  it 'should set status to "not_started" before save if not status is not defined' do
    task = Factory.build(:task, :id => nil, :status => nil)
    task.save!
    assert_equal Taskk::STATUS[0], task.status

    task = Factory.build(:task, :id => nil, :status => Taskk::STATUS[2])
    task.save!
    assert_equal Taskk::STATUS[2], task.status

    task = Factory(:task, :status => nil)
    task.save!
    assert_equal Taskk::STATUS[0], task.status

    task = Factory(:task, :status => Taskk::STATUS[1])
    task.save!
    assert_equal Taskk::STATUS[1], task.status
  end

end

