class CreateCoworkingSpaces < ActiveRecord::Migration
  def self.up
    create_table :coworking_spaces do |t|
      t.string :name
      t.integer :green
      t.integer :yellow
      t.integer :red

      t.timestamps
    end
  end

  def self.down
    drop_table :coworking_spaces
  end
end
