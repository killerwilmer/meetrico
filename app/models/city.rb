class City < ActiveRecord::Base
  default_scope :order => 'name DESC'

  has_many :coworking_space
end
