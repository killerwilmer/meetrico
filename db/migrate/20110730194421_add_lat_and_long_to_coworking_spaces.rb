class AddLatAndLongToCoworkingSpaces < ActiveRecord::Migration
  def self.up
    add_column :coworking_spaces, :lat, :string
    add_column :coworking_spaces, :long, :string
    add_column :coworking_spaces, :city_id, :integer
  end

  def self.down
    remove_column :coworking_spaces, :lat
    remove_column :coworking_spaces, :long
  end
end
