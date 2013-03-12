class AddObservationsToTables < ActiveRecord::Migration
  def self.up
    add_column :tables, :observations, :text
  end

  def self.down
    remove_column :tables, :observations
  end
end
