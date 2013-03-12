class AddOwnerToCoworkingSpaces < ActiveRecord::Migration
  def self.up
    add_column :coworking_spaces, :user_id, :integer
  end

  def self.down
    remove_column :users, :owner
  end
end
