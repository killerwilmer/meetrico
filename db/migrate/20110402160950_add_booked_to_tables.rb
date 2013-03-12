class AddBookedToTables < ActiveRecord::Migration
  def self.up
    add_column :tables, :booked, :boolean
  end

  def self.down
    remove_column :tables, :booked
  end
end
