class CoworkingSpace < ActiveRecord::Base
  has_many :tables
  belongs_to :user
  belongs_to :city
  belongs_to :category
  has_many :image_coworking_spaces
  has_many :images, :through => :image_coworking_spaces
  has_many :item_categories_coworking_spaces
  has_many :item_categories, :through => :item_categories_coworking_spaces

  attr_accessor :category_name

  scope :promotions, scoped
  scope :hot_promotions, promotions.limit(3)
  
  def create_tables
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
  
  def tables_left(type)
    (tables.where('tipo = ?', type).count) - (tables.where('booked = ? and tipo = ? ', true, type).count)
  end
  
  def percentage_booked
    tables_booked / tables.where(:tipo => 'resource').count.to_f
    
  end
  
  def tables_booked
    tables.where('tipo = ? ', 'resource').select(&:booked).count
  end

  def prices
    @prices ||= []

    item_categories.each do |category|
      @prices << category.price(self)
    end

    @prices
  end
  
end
