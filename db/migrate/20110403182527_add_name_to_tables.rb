class AddNameToTables < ActiveRecord::Migration
  def self.up
    add_column :tables, :name, :integer
  end

  def self.down
    remove_column :tables, :name
  end
end
