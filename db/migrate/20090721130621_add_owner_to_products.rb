class AddOwnerToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :owner, :string
  end

  def self.down
    remove_column :products, :owner
  end
end

