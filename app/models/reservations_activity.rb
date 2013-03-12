class ReservationsActivity < ActiveRecord::Base
  belongs_to :activity
  belongs_to :reservation

  self.per_page = 20
end
