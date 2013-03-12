class ReplaceCoworkingForTableInActivity < ActiveRecord::Migration
  def self.up
    remove_column :activities, :coworking_space_id
    add_column :activities, :table_id, :integer, :null => true
  end

  def self.down
  end
end
