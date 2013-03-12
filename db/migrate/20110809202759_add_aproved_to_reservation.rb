class AddAprovedToReservation < ActiveRecord::Migration
  def self.up
    add_column :reservations, :aproved, :boolean, :null => false, :default => false
  end

  def self.down
    remove_column :reservations, :aproved
  end
end
