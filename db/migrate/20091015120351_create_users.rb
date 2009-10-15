class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :login
      t.string :email
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.string :perishable_token
      t.datetime :last_login_at
      t.integer :login_count
      t.boolean :admin

      t.timestamps
    end

    add_index :users, :login
    add_index :users, :email
    add_index :users, :admin
  end

  def self.down
    drop_table :users
  end
end

