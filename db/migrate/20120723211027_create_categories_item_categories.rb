class CreateCategoriesItemCategories < ActiveRecord::Migration
  def self.up
    create_table :categories_item_categories, id: false do |t|
      t.references :category
      t.references :item_category
    end

    add_index :categories_item_categories, :item_category_id
    add_index :categories_item_categories, :category_id
  end

  def self.down
    drop_table :categories_item_categories
  end
end
