class CreateItemCategories < ActiveRecord::Migration
  def self.up
    create_table :item_categories do |t|
      t.string :name, :null => false
      t.text :description
      t.integer :price, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :item_categories
  end
end
