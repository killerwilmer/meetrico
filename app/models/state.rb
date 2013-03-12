class State < ActiveRecord::Base
  
  has_many :reservations
  has_many :tickets
end
