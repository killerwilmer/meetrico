class Table < ActiveRecord::Base
  #default_scope :order => 'name ASC'
  
  belongs_to :coworking_space
  belongs_to :item_category
  has_many :reservations
  has_many :image_tables
  has_many :images, :through => :image_tables
  has_many :activities
  

  self.per_page = 20
  
  def reserved?   
    return false if reservations.empty?

    reservations.last.end_time >= Time.now

  end
  
  def user
    reservations.last.user
  end
  
  def next_available_hour
    #guarradas mix
    next_hour = (Time.now + 1.hour).hour
    if next_hour < 10
      Chronic.parse("0" + next_hour.to_s + ":00")
    else
      Chronic.parse(next_hour.to_s + ":00")
    end
  end
end
