class CreateCities < ActiveRecord::Migration
  def self.up
    create_table :cities do |t|
      t.string :name, :null => false
      t.string :lat, :null => false
      t.string :long, :null => false
      t.string :description
      t.timestamps
    end
  end

  def self.down
    drop_table :cities
  end
end
