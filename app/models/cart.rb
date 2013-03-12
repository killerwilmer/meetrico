class Cart < ActiveRecord::Base
  has_many :line_items
  has_one :order
  has_one :ticket
  #before_create :validate_line
  
  def total_price
    # convert to array so it doesn't try to do sum on database directly
    line_items.to_a.sum(&:full_price)
  end


  #def validate_line
  #  line_item = LineItem.first :cart => self
  #  p line_item
  #end
end
