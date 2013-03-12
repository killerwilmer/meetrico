class RemovePlanImageCws < ActiveRecord::Migration
  def self.up
    remove_column :coworking_spaces, :plan_image
  end

  def self.down
  end
end
