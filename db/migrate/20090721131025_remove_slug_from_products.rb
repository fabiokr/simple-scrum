class RemoveSlugFromProducts < ActiveRecord::Migration
  def self.up
    remove_column :products, :slug
  end

  def self.down
    add_column :products, :slug, :string
  end
end

