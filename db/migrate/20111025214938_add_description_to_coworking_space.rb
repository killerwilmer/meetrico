class AddDescriptionToCoworkingSpace < ActiveRecord::Migration
  def self.up
    add_column :coworking_spaces, :description, :text
  end

  def self.down
    remove_column :coworking_spaces, :description
  end
end
