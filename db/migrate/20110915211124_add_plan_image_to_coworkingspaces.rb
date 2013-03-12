class AddPlanImageToCoworkingspaces < ActiveRecord::Migration
  def self.up
    add_column :coworking_spaces, :plan_image, :string, :null => true
  end

  def self.down
    remove_column :coworking_spaces, :plan_image
  end
end
