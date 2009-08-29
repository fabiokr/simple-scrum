class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|
      t.string :name
      t.text :description
      t.integer :estimative
      t.integer :priority

      t.references :product

      t.timestamps
    end

    add_index :stories, :product_id
    add_index :stories, :name
    add_index :stories, :estimative
    add_index :stories, :priority
    add_index :stories, :created_at
    add_index :stories, :updated_at
  end

  def self.down
    drop_table :stories
  end
end

