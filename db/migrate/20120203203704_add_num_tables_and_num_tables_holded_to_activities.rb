class AddNumTablesAndNumTablesHoldedToActivities < ActiveRecord::Migration
  def self.up
    add_column :activities, :num_tickets, :integer, :null => false, :default => 0
    add_column :activities, :num_owner_tickets, :integer, :null => false, :default => 0
  end

  def self.down
  end
end
