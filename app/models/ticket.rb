class Ticket < ActiveRecord::Base
  belongs_to :cart
  belongs_to :activity
  belongs_to :user
  belongs_to :state
  belongs_to :reservation
  
  self.per_page = 10
  
end
