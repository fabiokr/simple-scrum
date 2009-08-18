# == Schema Information
#
# Table name: sprints
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  velocity   :float
#  start      :datetime
#  end        :datetime
#  product_id :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class SprintTest < ActiveSupport::TestCase
  context 'A Sprint' do

    setup do
      @sprint = Factory.create(:sprint)
    end

    should_have_db_columns :id, :name, :start, :end, :product_id, :created_at, :updated_at

    should_validate_presence_of :name, :product

    should_ensure_length_in_range :name, (1..60)

    should_belong_to :product

    should_validate_numericality_of :velocity

  end
end

