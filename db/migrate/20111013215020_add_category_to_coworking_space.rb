class AddCategoryToCoworkingSpace < ActiveRecord::Migration
  def self.up
    add_column :coworking_spaces, :category_id, :integer
  end

  def self.down
    remove_column :coworking_spaces, :category_id
  end
end
