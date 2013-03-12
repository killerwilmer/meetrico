class AddNumProdItemCategoriesCws < ActiveRecord::Migration
  def self.up
   add_column :item_categories_coworking_spaces, :num_tables, :integer, :default => 0
  end

  def self.down
  end
end
