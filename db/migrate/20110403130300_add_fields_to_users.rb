class AddFieldsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :avatar, :string
    add_column :users, :gender, :string
  end

  def self.down
    remove_column :users, :gender
    remove_column :users, :avatar
  end
end
