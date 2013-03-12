class AddCategoryToTables < ActiveRecord::Migration
  def self.up
    add_column :tables, :item_category_id, :integer, :null => false, :default => 0
  end

  def self.down
    remove_column :tables, :item_category_id
  end
end
