class AddMainImageToActivities < ActiveRecord::Migration
  def self.up
    add_column :activities, :main_image_url, :text
  end

  def self.down
    remove_column :activities, :main_image_url
  end
end
