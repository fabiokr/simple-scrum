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

  it { should have_db_columns :id, :name, :description, :estimative, :unplanned, :story_id, :sprint_id, :created_at, :updated_at }
  it { should belong_to :story }
  it { should belong_to :sprint }

  it { should validate_presence_of(:story, :sprint) }
  it { should validate_length_of(:name, :within => 1..200) }
  it { should validate_inclusion_of(:status, :in => Taskk::STATUS) }
  it { should validate_numericality_of :estimative }

  it 'should set status to "not_started" before save if not status is not defined' do
    task = Factory.build(:task, :id => nil, :status => nil)
    task.save!
    assert_equal Taskk::TODO, task.status

    task = Factory.build(:task, :id => nil, :status => Taskk::DONE)
    task.save!
    assert_equal Taskk::DONE, task.status

    task = Factory(:task, :status => nil)
    task.save!
    assert_equal Taskk::TODO, task.status

    task = Factory(:task, :status => Taskk::DOING)
    task.save!
    assert_equal Taskk::DOING, task.status
  end

  it "should update sprint estimated_velocity after save" do
    sprint = Factory(:sprint)
    story = Factory(:story)
    task1 = Factory(:task, :sprint => sprint, :story => story)

    sprint.reload
    sprint.estimated_velocity.should == story.estimative

    task2 = Factory(:task, :sprint => sprint, :story => story)

    sprint.reload
    sprint.estimated_velocity.should == story.estimative

    story.estimative = 20
    story.save!

    sprint.reload
    sprint.estimated_velocity.should == 20
  end

  it "should update sprint velocity after save" do
    story1 = Factory(:story)
    story2 = Factory(:story)

    sprint = Factory(:sprint, :product => story1.product)

    task1 = Factory(:task, :sprint => sprint, :story => story1, :status => Taskk::TODO)
    task2 = Factory(:task, :sprint => sprint, :story => story1, :status => Taskk::TODO)
    task3 = Factory(:task, :sprint => sprint, :story => story2, :status => Taskk::TODO)
    task4 = Factory(:task, :sprint => sprint, :story => story2, :status => Taskk::TODO)

    sprint.reload
    sprint.velocity.should == 0

    task1.status = Taskk::DONE
    task1.save!

    #as we still miss the task2 as done, the estimative should not yet be considered
    sprint.reload
    sprint.velocity.should == 0

    task2.status = Taskk::DONE
    task2.save!

    #now it should!
    sprint.reload
    sprint.velocity.should == story1.estimative

    task3.status = Taskk::DONE
    task3.save!

    #as we still miss the task4 as done, the estimative should not yet be considered
    sprint.reload
    sprint.velocity.should == story1.estimative

    task4.status = Taskk::DONE
    task4.save!

    #now it should!
    sprint.reload
    sprint.velocity.should == story1.estimative + story2.estimative
  end

end

