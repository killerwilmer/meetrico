class AddCwsItemCategory < ActiveRecord::Migration
  def self.up
    add_column  :item_categories, :coworking_space_id, :integer, :null => true
  end

  def self.down
  end
end
