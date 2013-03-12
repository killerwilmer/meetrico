class CreateItemCategoriesCoworkingSpaces < ActiveRecord::Migration
  def self.up
    create_table :item_categories_coworking_spaces do |t|
      t.integer :coworking_space_id, :default => 0
      t.integer :line_category_id, :default => 0
      t.integer :green
      t.integer :yellow
      t.integer :red
      t.timestamps
    end
  end

  def self.down
    drop_table :item_categories_coworking_spaces
  end
end
