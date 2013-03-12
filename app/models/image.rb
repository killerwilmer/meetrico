class Image < ActiveRecord::Base
  has_many :coworking_spaces
  has_many :tables
  has_many :image_coworking_spaces, :through => :coworking_spaces
end
