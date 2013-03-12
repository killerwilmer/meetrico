class AddDurationActivities < ActiveRecord::Migration
  def self.up
    add_column :activities, :duration, :integer
  end

  def self.down
    remove_column :activities, :duration
  end
end
