class CreateImageTables < ActiveRecord::Migration
  def self.up
    create_table :image_tables do |t|
      t.integer :image_id
      t.integer :table_id
      t.timestamps
    end
  end

  def self.down
    drop_table :image_tables
  end
end
