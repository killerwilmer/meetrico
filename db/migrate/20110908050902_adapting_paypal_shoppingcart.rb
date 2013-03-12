class AdaptingPaypalShoppingcart < ActiveRecord::Migration
  def self.up
    remove_column :line_items, :product_id
    add_column :line_items, :table_id, :integer, :null => true
  end

  def self.down
  end
end
