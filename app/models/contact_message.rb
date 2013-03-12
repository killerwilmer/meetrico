class ContactMessage
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name, :email, :message, :url, :item_category_id

  #validates_presence_of :name
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  # Returns the associated item_category, returns nil if none
  def item_category
    if item_category_id.present?
      @item_category ||= ItemCategory.find(item_category_id)
    end
  end

  def description
    item_category.description
  end

  def promo_name
    item_category.name
  end

  def calculated_url
    item_category.target_url || "http://www.meetrico.com/coworking_spaces/#{item_category.coworking_spaces.first.id rescue nil}"
  end

end
