class ChangeColumnItemCategoriesCws < ActiveRecord::Migration
  def self.up
    remove_column  :item_categories_coworking_spaces, :line_category_id
    add_column  :item_categories_coworking_spaces, :item_category_id, :integer
  end

  def self.down
  end
end
