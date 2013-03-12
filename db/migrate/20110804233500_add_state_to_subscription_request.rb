class AddStateToSubscriptionRequest < ActiveRecord::Migration
  def self.up
    add_column :subscription_requests, :state, :integer, :null => false, :default => 1
  end

  def self.down
    remove_column :subscription_requests, :state
  end
end
