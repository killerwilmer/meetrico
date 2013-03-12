class CreateActivityTables < ActiveRecord::Migration
  def self.up
    create_table :activity_tables do |t|
      t.integer :activity_id
      t.integer :table_id
      t.timestamps
    end
  end

  def self.down
    drop_table :activity_tables
  end
end
