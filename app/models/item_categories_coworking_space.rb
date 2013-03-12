class ItemCategoriesCoworkingSpace < ActiveRecord::Base
  belongs_to :coworking_space
  belongs_to :item_category

  after_create :create_tables
  
  def create_tables    
    if self.num_tables > 0
      self.num_tables.times do |t|
        table = Table.create :coworking_space => coworking_space,
          :name => "Item #{t+1}",
          :booked => false,
          :tipo => "resource",
          :item_category => item_category        
      end
    end
  end
end
