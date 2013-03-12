class AddReservationOnTicket < ActiveRecord::Migration
  def up
    add_column :tickets, :reservation_id, :integer, :null => false, :default => 0
  end

  def down
  end
end
