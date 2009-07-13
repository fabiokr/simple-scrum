class CreateSprints < ActiveRecord::Migration
  def self.up
    create_table :sprints do |t|
      t.string :name
      t.timestamp :start
      t.timestamp :end
      t.references :backlog

      t.timestamps
    end
  end

  def self.down
    drop_table :sprints
  end
end
