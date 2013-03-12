class AddCardVerificationOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :card_verification, :string, :null => false, :default => "123"
  end

  def self.down
    remove_column :orders, :card_verification
  end
end
