class RemoveCwsItemCategory < ActiveRecord::Migration
  def self.up
    remove_column  :item_categories, :coworking_space_id
  end

  def self.down
  end
end
