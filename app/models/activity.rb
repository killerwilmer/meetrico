class Activity < ActiveRecord::Base
  #has_many :activity_tables
  #has_many :tables, :through => :activity_tables
  belongs_to :table
  before_create :set_end_date
  has_many :tickets
  has_many :reservations_activities
  has_many :reservations, :through => :reservations_activities
  #before_destroy :destroy_tickets

  scope :active, where('end_date > ? ', DateTime.now)

  self.per_page = 25

  

  def percentage_booked
    
    if self.num_available_tickets > 0 && self.num_tickets > 0
      ((self.num_tickets.to_f - self.num_owner_tickets.to_f) - self.num_available_tickets.to_f) / self.num_tickets.to_f
    else
      1
    end

  end

  def set_end_date
    self.end_date = self.start_date + self.duration.send('hours')
  end

  def price
    if percentage_booked <= 0.3
      green
    elsif percentage_booked <= 0.6
      yellow
    else
      red
    end
  end


end
