class AddSprintToBacklogItem < ActiveRecord::Migration
  def self.up
    change_table :backlog_items do |t|
      t.integer :sprint_id
    end
  end

  def self.down
    change_table :backlog_items do |t|
      t.remove :sprint_id
    end
  end
end

