class AdaptingLineCategories < ActiveRecord::Migration
  def self.up
    add_column :item_categories, :green, :integer, :default => 0
    add_column :item_categories, :yellow, :integer, :default => 0
    add_column :item_categories, :red, :integer, :default => 0
    remove_column :item_categories, :price
  end

  def self.down
    remove_column :item_categories, :green, :integer
    remove_column :item_categories, :yellow, :integer
    remove_column :item_categories, :red, :integer
    add_column :item_categories, :price
  end
end
