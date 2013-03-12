class TranslateReservationToStateMachine < ActiveRecord::Migration
  def self.up
    remove_column :reservations, :aproved
    add_column :reservations, :state_id, :integer, :null => false, :default => 1
  end

  def self.down
    #add_column :reservations, :aproved, :boolean, :null => false, :default => false
    #remove_column :reservations, :state_id
  end
end
