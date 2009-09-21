class AddUnplannedToTaskk < ActiveRecord::Migration
  def self.up
    add_column :tasks, :unplanned, :boolean
  end

  def self.down
    remove_column :tasks, :unplanned
  end
end

