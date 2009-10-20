class AddUserstampFields < ActiveRecord::Migration
  def self.up
    change_table :products do |t|
      t.integer :creator_id, :updater_id
      t.index :creator_id
      t.index :updater_id
    end

    change_table :sprints do |t|
      t.integer :creator_id, :updater_id
      t.index :creator_id
      t.index :updater_id
    end

    change_table :stories do |t|
      t.integer :creator_id, :updater_id
      t.index :creator_id
      t.index :updater_id
    end

    change_table :tasks do |t|
      t.integer :creator_id, :updater_id
      t.index :creator_id
      t.index :updater_id
    end
  end

  def self.down
    remove_column :products, :creator_id, :updater_id
    remove_column :sprints, :creator_id, :updater_id
    remove_column :stories, :creator_id, :updater_id
    remove_column :tasks, :creator_id, :updater_id
  end
end

