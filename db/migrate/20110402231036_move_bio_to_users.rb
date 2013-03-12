class MoveBioToUsers < ActiveRecord::Migration
  def self.up
    remove_column :reservations, :bio
    add_column :users, :bio, :text
  end

  def self.down
    remove_column :users, :bio
    add_column :reservations, :bio, :text
  end
end