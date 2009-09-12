class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :name
      t.string :status
      t.text :description
      t.integer :estimative
      t.references :story
      t.references :sprint

      t.timestamps
    end

    add_index :tasks, :name
    add_index :tasks, :status
    add_index :tasks, :story_id
    add_index :tasks, :sprint_id
    add_index :tasks, :estimative
    add_index :tasks, :created_at
    add_index :tasks, :updated_at
  end

  def self.down
    drop_table :tasks
  end
end

