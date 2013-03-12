class AddCardNumberOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :card_number, :string, :null => true
  end

  def self.down
    remove_column :orders, :card_number
  end
end
