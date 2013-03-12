class CreateSubscriptionRequests < ActiveRecord::Migration
  def self.up
    create_table :subscription_requests do |t|
      t.string :phone, :null => false
      t.integer :city_id, :null => false
      t.integer :user_id, :null => false
      t.string :description, :null => true
      t.timestamps
    end
  end

  def self.down
    drop_table :subscription_requests
  end
end
