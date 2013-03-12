class RemovePricesItemCategory < ActiveRecord::Migration
  def self.up
    remove_column :item_categories, :green
    remove_column :item_categories, :yellow
    remove_column :item_categories, :red
    
  end

  def self.down
  end
end
