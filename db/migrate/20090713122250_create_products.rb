class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.string :owner

      t.timestamps
    end

    add_index :products, :name
    add_index :products, :owner
    add_index :products, :created_at
    add_index :products, :updated_at
  end

  def self.down
    drop_table :products
  end
end

