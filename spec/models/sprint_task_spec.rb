# == Schema Information
#
# Table name: sprint_tasks
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  story_id    :integer
#  sprint_id   :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SprintTask do
  before(:each) do
    @task = Factory.create(:sprint_task)
  end

  it 'should be valid' do
    @task.should be_valid
  end

  it { should have_db_columns :id, :name, :description, :story_id, :sprint_id, :created_at, :updated_at }
  it { should validate_presence_of(:story, :sprint) }
  it { should validate_length_of(:name, :within => 1..200) }
  it { should belong_to :story }
  it { should belong_to :sprint }
end

