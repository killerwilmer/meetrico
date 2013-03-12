class AddImageItemCategories < ActiveRecord::Migration
  def self.up
    add_column :item_categories, :image_url, :string, :null => true
  end

  def self.down
  end
end
