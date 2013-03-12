class ChangeImageUrlTypeItemCategories < ActiveRecord::Migration
  def self.up
    change_table :item_categories do |t|
      t.change :image_url, :text
    end
  end

  def self.down
    change_table :item_categories do |t|
      t.change :image_url, :string
    end
  end
end
