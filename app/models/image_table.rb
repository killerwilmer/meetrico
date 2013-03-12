class ImageTable < ActiveRecord::Base
  belongs_to :image
  belongs_to :table
end
