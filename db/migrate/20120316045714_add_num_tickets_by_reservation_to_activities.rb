class AddNumTicketsByReservationToActivities < ActiveRecord::Migration
  def change
    add_column :reservations_activities, :num_tickets, :integer, :null => false, :default => 0
  end
end
