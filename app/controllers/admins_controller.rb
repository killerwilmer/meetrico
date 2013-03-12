class AdminsController < InheritedResources::Base

  before_filter :authenticate_admin!
  
  layout 'admin'

  def index
  end

  def prueba
    
  end
  
end
