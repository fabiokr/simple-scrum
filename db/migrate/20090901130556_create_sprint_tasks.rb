class CreateSprintTasks < ActiveRecord::Migration
  def self.up
    create_table :sprint_tasks do |t|
      t.string :name
      t.string :status
      t.text :description
      t.references :story
      t.references :sprint

      t.timestamps
    end

    add_index :sprint_tasks, :name
    add_index :sprint_tasks, :status
    add_index :sprint_tasks, :story_id
    add_index :sprint_tasks, :sprint_id
    add_index :sprint_tasks, :created_at
    add_index :sprint_tasks, :updated_at
  end

  def self.down
    drop_table :sprint_tasks
  end
end

