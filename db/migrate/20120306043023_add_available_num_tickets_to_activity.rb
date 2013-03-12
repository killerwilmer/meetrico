class AddAvailableNumTicketsToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :num_available_tickets, :integer, :null => false, :default => 0
  end
end
