class CreateConfigurations < ActiveRecord::Migration
  def self.up
    create_table :configurations do |t|
      t.string :feature
      t.string :value
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :configurations
  end
end
