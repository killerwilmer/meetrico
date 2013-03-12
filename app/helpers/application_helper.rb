module ApplicationHelper
  
  def north_or_south_css(index)
    index < 4 ? "south" : "north"
  end
  
  def thermometer_css
    if @coworking_space.percentage_booked <= 0.3
      "green"
    elsif @coworking_space.percentage_booked <= 0.6
      "yellow"
    else
      "red"
    end 
  end

  def item_category_thermometer_css(category, coworking_space)
    if category.percentage_booked(coworking_space) <= 0.3
      "green"
    elsif category.percentage_booked(coworking_space) <= 0.6
      "yellow"
    else
      "red"
    end
  end
  
  def activity_thermometer_css
    
    if @activity.percentage_booked <= 0.3
      "green"
    elsif @activity.percentage_booked <= 0.6
      "yellow"
    else
      "red"
    end
  end

  def reserved_or_available_css(table)
    table.reserved? ? "reserved" : "available"
  end
  
  def reserved_by_current_user_css(table)
    if table.reserved? and current_user == table.user
      " current"
    end
  end

  def has_reservations? user
    if not user.nil?
      return false unless Reservation.where("user_id = ? ", user.id).active.first
      true
    else
      false
    end

    
  end

  def how_many_reservations? user
    Reservation.where("user_id = ?", user.id).active.count if not user.nil?    
  end

  def authenticate_owner_or_admin
    unless current_user.try(:owner?) or admin_signed_in?
      flash[:alert]  = "Gracias por usar Meetrico.com, la red lider de espacios compartidos."
      redirect_to root_url
    end
  end

  def choose_layout_all_profiles
    
    return 'application' if not current_user.try(:owner?) and not admin_signed_in?
    return 'owners' if current_user.try(:owner?)
    return 'admin' if admin_signed_in?
  end

  
  
end
