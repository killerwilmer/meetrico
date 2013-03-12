class ChangeStartTimeToTime < ActiveRecord::Migration
  def self.up
    remove_column :reservations, :start_time
    add_column :reservations, :start_time, :datetime
  end

  def self.down
    remove_column :reservations, :start_time
    add_column :reservations, :start_time, :datetime
  end
end