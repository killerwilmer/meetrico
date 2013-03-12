class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :cart_id, :null => false
      t.integer :activity_id, :null => false
      t.integer :user_id, :null => false
      t.integer :state_id, :null => false
      t.timestamps
    end
  end
  
end
