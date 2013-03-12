class ItemCategory < ActiveRecord::Base
  has_many :tables
  has_many :item_categories_coworking_spaces
  has_many :coworking_spaces, :through => :item_categories_coworking_spaces

  has_and_belongs_to_many :categories

  before_validation :adjust_prices

  scope :hot_promotions, order('updated_at desc').limit(3)

  def price(coworking_space)
    if percentage_booked(coworking_space) <= 0.3
      item_categories_coworking_spaces.where(:coworking_space_id => coworking_space.id).first.green
    elsif percentage_booked(coworking_space) <= 0.6
      item_categories_coworking_spaces.where(:coworking_space_id => coworking_space.id).first.yellow
    else
      item_categories_coworking_spaces.where(:coworking_space_id => coworking_space.id).first.yellow#cambio
    end
    
  end

  def tables_left(type)
    (tables.where('tipo = ?', type).count) - (tables.where('booked = ? and tipo = ? ', true, type).count)
  end

  def tables_left_by_coworking_space(type, coworking_space)
    (tables.where('tipo = ? and coworking_space_id = ?', type, coworking_space.id).count) - (tables.where('booked = ? and tipo = ? and coworking_space_id = ? and item_category_id = ?', true, type, coworking_space.id, self.id).count)
  end

  def percentage_booked(coworking_space)
    tables_booked(coworking_space) / tables.where(:tipo => 'resource', :item_category_id => self.id, :coworking_space_id => coworking_space.id).count.to_f
  end

  def tables_booked(coworking_space)
    tables.where('tipo = ? and item_category_id = ? and coworking_space_id = ?', 'resource', self.id, coworking_space.id).select(&:booked).count
  end

  def discount_percentage
    100 * (normal_price-offered_price)/normal_price
  end
  
  def mi_precio
    normal_price
  end

  private
  # Adjusts prices to be equal if one of them is not set (0% discount)
  def adjust_prices
    self.offered_price = self.normal_price unless offered_price
    self.normal_price = self.offered_price unless normal_price
  end
  
end
