class AddAddressToCoworkingSpaces < ActiveRecord::Migration
  def self.up
    add_column :coworking_spaces, :address, :text
  end

  def self.down
    remove_column :coworking_spaces, :address
  end
end
