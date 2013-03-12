module ActivitiesHelper


  def activities_all_prices(limit, price, category_id)
    list = []
    p category_id
    activities = Activity.limit(limit).order('updated_at desc').all if price == "" and category_id == ""
    activities = Activity.joins(:coworking_space).limit(limit).order('updated_at desc').where(:coworking_spaces => {:category_id => category_id}) if category_id != ""
   

    activities.each { |activity|

      next_available = next_to_be_booked(activity)
      data = {}
      data['id'] = activity.id.to_s rescue ''
      data["name"] = activity.name rescue ''
      data["green"] = activity.green.to_s rescue ''
      data["tables_left"] = activity.tables_left.to_s rescue '0'
      data["image_url"] = activity.main_image_url rescue ""
      data["category_name"] = activity.coworking_space.category.name rescue ''
      data["category_id"] = activity.coworking_space.category.id rescue ''
      data["user"] = activity.coworking_space.user rescue ''
      data["city"] = activity.coworking_space.city rescue ''
      data["description"] = activity.description rescue ''
      data["price"] = price rescue ''
      data["address"] = activity.coworking_space.address rescue ''
      data["next_available_table"] =  next_available if next_available rescue ''
      if price != ""
        price.each do |temp_price|
          range = temp_price.split("-")
          bottom = (range[0]).to_i if range[0]
          top = (range[1]).to_i if range[1]

          list << data if activity.price <= top and activity.price >= bottom
        end
      else
        list << data
      end
      
      
    }

    return list
  end

  def next_to_be_booked(activity)
    #availables = activity.tables - activity.tables.where(:booked => true)
    #availables.first
    Activity.first
  end
  

end
