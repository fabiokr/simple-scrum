class AddSlugToProduct < ActiveRecord::Migration
  def self.up
    change_table :products do |t|
      t.string :slug
      t.index :slug
    end
  end

  def self.down
    remove_column :products, :slug
  end
end

