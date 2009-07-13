require 'test_helper'

class SprintTest < ActiveSupport::TestCase
  context 'A Sprint' do

    setup do
      @sprint = Factory.create(:sprint)
    end

    should_have_db_columns :id, :name, :start, :end, :backlog_id, :created_at, :updated_at

    should_validate_presence_of :name

    should_ensure_length_in_range :name, (1..60)

    should_belong_to :backlog

  end
end

