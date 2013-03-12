class AddEndTimeToReservations < ActiveRecord::Migration
  def self.up
    add_column :reservations, :end_time, :datetime
  end

  def self.down
    remove_column :reservations, :end_time
  end
end
