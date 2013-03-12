class AddTypeToTables < ActiveRecord::Migration
  def self.up
    add_column :tables, :tipo, :string, :null => true, :default => 'resource'
  end

  def self.down
    remove_column :tables, :tipo
  end
end
