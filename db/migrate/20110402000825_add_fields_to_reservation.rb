class AddFieldsToReservation < ActiveRecord::Migration
  def self.up
    add_column :reservations, :start_time, :time
    add_column :reservations, :duration, :integer
    add_column :reservations, :bio, :text
    add_column :reservations, :user_id, :integer
  end

  def self.down
    remove_column :reservations, :user_id
    remove_column :reservations, :bio
    remove_column :reservations, :duration
    remove_column :reservations, :start_time
  end
end
