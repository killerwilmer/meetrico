class CreateActivity < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.string :name, :null => false
      t.text :description, :null => false
      t.integer :coworking_space_id, :null => false
      t.datetime :date, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :activities
  end
end
