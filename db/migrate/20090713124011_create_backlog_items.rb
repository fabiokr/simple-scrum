class CreateBacklogItems < ActiveRecord::Migration
  def self.up
    create_table :backlog_items do |t|
      t.string :story
      t.text :description
      t.float :estimative

      t.references :backlog
      t.references :backlog_item

      t.timestamps
    end
  end

  def self.down
    drop_table :backlog_items
  end
end

