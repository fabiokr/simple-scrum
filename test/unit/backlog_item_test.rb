require 'test_helper'

class BacklogItemTest < ActiveSupport::TestCase
  context 'A Backlog Item' do

    setup do
      @backlog_item = Factory.create(:backlog_item)
    end

    should_have_db_columns :id, :story, :description, :estimative, :backlog_id, :backlog_item_id, :created_at, :updated_at

    should_validate_presence_of :story

    should_ensure_length_in_range :story, (1..200)

    should_belong_to :backlog, :backlog_item, :sprint

    should_validate_numericality_of :estimative

  end
end

