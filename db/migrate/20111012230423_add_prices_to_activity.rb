class AddPricesToActivity < ActiveRecord::Migration
  def self.up
    add_column :activities, :green, :integer
    add_column :activities, :yellow, :integer
    add_column :activities, :red, :integer
  end

  def self.down
    remove_column :activities, :green
    remove_column :activities, :yellow
    remove_column :activities, :red
  end
end
