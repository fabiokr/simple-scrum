require 'test_helper'

class BacklogTest < ActiveSupport::TestCase
  context 'A Backlog' do
    setup do
      Factory.create(:backlog)
    end
    should_have_db_columns :id, :project_name, :slug, :created_at, :updated_at

    should_ensure_length_in_range :project_name, (1..60)

    should_validate_uniqueness_of :slug
    should_ensure_length_in_range :slug, (1..20)
    should_allow_values_for :slug, 'valid', 'valid-slug', 'valid12-slug-yeah'
    should_not_allow_values_for :slug, 'not%valid', '/nops', 'also not', 'NOO'

  end
end

