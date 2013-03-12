class AddRecurrencyReservation < ActiveRecord::Migration
  def self.up
    add_column :reservations, :recurrent, :boolean, :null => false, :default => false
  end

  def self.down
  end
end
