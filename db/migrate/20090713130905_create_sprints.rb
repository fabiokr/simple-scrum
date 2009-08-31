class CreateSprints < ActiveRecord::Migration
  def self.up
    create_table :sprints do |t|
      t.string :name
      t.float :velocity
      t.date :start
      t.date :end
      t.references :product

      t.timestamps
    end

    add_index :sprints, :product_id
    add_index :sprints, :name
    add_index :sprints, :velocity
    add_index :sprints, :start
    add_index :sprints, :end
    add_index :sprints, :created_at
    add_index :sprints, :updated_at
  end

  def self.down
    drop_table :sprints
  end
end

