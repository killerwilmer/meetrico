class Reservation < ActiveRecord::Base
  belongs_to :table
  belongs_to :state
  belongs_to :user
  
  attr_accessor :name
  
  after_create :set_table_as_booked
  #before_create :set_start_time
  before_create :set_end_time
  before_destroy :liberate_table
  has_many :reservations_activities
  has_many :activities, :through => :reservations_activities

  self.per_page = 20
  
  scope :active, where('end_time > ? and state_id in (\'1\', \'2\', \'3\')', DateTime.now)

  def liberate_table
    self.table.update_attribute(:booked, false) if self.table
  end
  def set_table_as_booked
    self.table.update_attribute(:booked, true)
  end
  
  def set_start_time
    self.start_time = table.next_available_hour
  end
  
  def set_end_time
    self.end_time = self.start_time + self.duration.send('hours')
  end

  def aproved?
    self.aproved
  end

  def inactive?
    return true if DateTime.now > self.end_time
    return false
  end
end
