class Category < ActiveRecord::Base
  has_many :coworking_spaces
  has_and_belongs_to_many :item_categories
end
