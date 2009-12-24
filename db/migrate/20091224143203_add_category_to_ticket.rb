class AddCategoryToTicket < ActiveRecord::Migration
  def self.up
    change_table :tickets do |t|
      t.integer :category_id
      t.index :category_id
    end

    remove_column :tickets, :color
  end

  def self.down
    remove_column :tickets, :category_id

    change_table :tickets do |t|
      t.integer :color
      t.index :color
    end
  end
end

