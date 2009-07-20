require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  context 'A Story' do

    setup do
      @story = Factory.create(:story)
    end

    should_have_db_columns :id, :name, :description, :estimative, :priority, :product_id, :created_at, :updated_at

    should_validate_presence_of :name, :product_id

    should_ensure_length_in_range :name, (1..200)

    should_belong_to :product

    should_validate_numericality_of :estimative, :priority

  end
end

