class ChangeStoryEstimativeToInt < ActiveRecord::Migration
  def self.up
    change_column(:stories, :estimative, :integer)
  end

  def self.down
    change_column(:stories, :estimative, :float)
  end
end

