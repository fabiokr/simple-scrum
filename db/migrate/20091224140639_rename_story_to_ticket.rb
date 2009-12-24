class RenameStoryToTicket < ActiveRecord::Migration
  def self.up
    rename_table :stories, :tickets
  end

  def self.down
    rename_table :tickets, :stories
  end
end

