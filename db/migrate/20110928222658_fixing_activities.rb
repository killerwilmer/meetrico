class FixingActivities < ActiveRecord::Migration
  def self.up
    rename_column :activities, :date, :start_date
    add_column :activities, :end_date, :datetime
  end

  def self.down
    rename_column :activities, :start_date, :date
    remove_column :activities, :end_date
  end
end
