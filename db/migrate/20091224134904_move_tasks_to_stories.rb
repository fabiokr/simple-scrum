class MoveTasksToStories < ActiveRecord::Migration
  def self.up
    change_table :stories do |t|
      t.integer :status
      t.references :sprint
      t.boolean :unplanned
      t.timestamp :status_changed_at
      t.index :status
      t.index :sprint_id
      t.index :unplanned
      t.index :status_changed_at
    end

    drop_table :tasks
  end

  def self.down
    remove_column :stories, :sprint_id, :unplanned, :status, :status_changed_at

    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.integer :status
      t.integer :estimative
      t.references :story
      t.references :sprint
      t.boolean :unplanned
      t.timestamp :status_changed_at

      t.timestamps
    end

    add_index :tasks, :name
    add_index :tasks, :status
    add_index :tasks, :unplanned
    add_index :tasks, :story_id
    add_index :tasks, :sprint_id
    add_index :tasks, :estimative
    add_index :tasks, :status_changed_at
    add_index :tasks, :created_at
    add_index :tasks, :updated_at
  end
end

