class ApplicationController < ActionController::Base


  helper_method :current_cart
  #protect_from_forgery
  
  #before_filter :load_utopicus
  #before_filter :authenticate_admin!
  before_filter :current_user
  #before_filter :current_cart
  #layout 'admin'
  def load_utopicus
    #@utopicus = CoworkingSpace.find_by_name("Utopic_US")
  end

#  def after_sign_in_path_for(resource)
#    if resource.try(:owner?)
#      owners_path
#    else
#      root_path
#    end
#  end

  def current_cart
    if session[:cart_id]
      @current_cart ||= Cart.find(session[:cart_id])
      session[:cart_id] = nil if @current_cart.purchased_at
    end
    if session[:cart_id].nil?
      @current_cart = Cart.create!
      session[:cart_id] = @current_cart.id
    end
    @current_cart
  end

  
end
