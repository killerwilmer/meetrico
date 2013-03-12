class AddRecurrentActivities < ActiveRecord::Migration
  def self.up
    add_column :activities, :recurrent, :boolean, :null => false, :default => false
  end

  def self.down
  end
end
