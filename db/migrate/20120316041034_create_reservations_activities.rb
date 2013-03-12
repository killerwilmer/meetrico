class CreateReservationsActivities < ActiveRecord::Migration
  def change
    create_table :reservations_activities do |t|
      t.integer :reservation_id, :default => 0
      t.integer :activity_id, :default => 0
      t.timestamps
    end
  end
end
