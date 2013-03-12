class DropActivitiesTables < ActiveRecord::Migration
  def up
    drop_table :activity_tables
  end

  def down
  end
end
