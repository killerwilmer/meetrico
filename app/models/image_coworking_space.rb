class ImageCoworkingSpace < ActiveRecord::Base
  belongs_to :image
  belongs_to :coworking_space
end
