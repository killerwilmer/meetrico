class AddTargetUrlToItemCategories < ActiveRecord::Migration
  def change
    add_column :item_categories, :target_url, :string
  end
end
