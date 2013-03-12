class CreateImageCoworkingSpaces < ActiveRecord::Migration
  def self.up
    create_table :image_coworking_spaces do |t|
      t.integer :image_id
      t.integer :coworking_space_id
      t.timestamps
    end
  end

  def self.down
    drop_table :image_coworking_spaces
  end
end
