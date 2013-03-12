class AddPricesToItemCategories < ActiveRecord::Migration
  def change
    add_column :item_categories, :normal_price, :decimal, precision: 10, scale: 2, default: 0.00
    add_column :item_categories, :offered_price, :decimal, precision: 10, scale: 2, default: 0.00
  end
end
