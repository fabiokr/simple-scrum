# == Schema Information
#
# Table name: products
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  owner      :string(255)
#

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  context 'A Product' do
    setup do
      Factory.create(:product)
    end
    should_have_db_columns :id, :name, :owner, :created_at, :updated_at

    should_validate_presence_of :name, :owner

    should_ensure_length_in_range :name, (1..60)
    should_ensure_length_in_range :owner, (1..60)

    should_have_many :stories, :sprints

  end
end

