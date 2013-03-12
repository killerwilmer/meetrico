module CoworkingSpacesHelper


  def coworking_spaces_all_prices(limit, price, category_id)
    list = []

    coworking_spaces = CoworkingSpace.limit(limit).order('updated_at desc').all if price == "" and category_id == ""    
    coworking_spaces = CoworkingSpace.limit(limit).order('updated_at desc').where(:category_id => category_id) if category_id != ""

    coworking_spaces.each { |coworking_space|    
      
      data = {}
      data['id'] = coworking_space.id.to_s rescue ''
      data["name"] = coworking_space.name rescue ''
      data["green"] = coworking_space.green.to_s rescue ''
      data["tables_left"] = coworking_space.tables_left('resource').to_s rescue ''
      data["image_url"] = coworking_space.images[0].url_path rescue ''
      data["category_name"] = coworking_space.category.name rescue ''
      data["category"] = coworking_space.category rescue ''
      data["user"] = coworking_space.user rescue ''
      data["city"] = coworking_space.city rescue ''
      data["price"] = price rescue ''
      data["address"] = coworking_space.address rescue ''
      if price != ""
        price.each do |temp_price|
          range = temp_price.split("-")
          bottom = (range[0]).to_i if range[0]
          top = (range[1]).to_i if range[1]
          coworking_space.prices.each do |price|
            list << data if price <= top and price >= bottom and !list.include? data
          end
        end
      else
        list << data
      end
      
    }

    return list
  end

  def coworking_spaces_in_green_price(limit, city_id, category_id)
    list = []

    coworking_spaces = CoworkingSpace.limit(limit).order('updated_at desc').all if city_id == "" and category_id == ""
    coworking_spaces = CoworkingSpace.limit(limit).order('updated_at desc').where(:city_id => city_id, :category_id => category_id) if city_id != "" and category_id != ""
    coworking_spaces = CoworkingSpace.limit(limit).order('updated_at desc').where(:city_id => city_id) if city_id != ""
    coworking_spaces = CoworkingSpace.limit(limit).order('updated_at desc').where(:category_id => category_id) if category_id != ""
    
    coworking_spaces.each { |coworking_space|
      
      if coworking_space.percentage_booked <= 0.3
        data = {}
        data['id'] = coworking_space.id.to_s rescue ''
        data["name"] = coworking_space.name rescue ''
        data["green"] = coworking_space.green.to_s rescue ''
        data["tables_left"] = coworking_space.tables_left('resource').to_s rescue ''
        data["image_url"] = coworking_space.images[0].url_path rescue ''
        data["category_name"] = coworking_space.category.name rescue ''
        data["category"] = coworking_space.category rescue ''
        data["user"] = coworking_space.user rescue ''
        data["city"] = coworking_space.city rescue ''
        list << data
      end
    }

    return list
  end

  def coworking_spaces_in_yellow_price(limit, city_id, category_id)
    list = []
    CoworkingSpace.limit(limit).all.each { |coworking_space|
      list << coworking_space if coworking_space.percentage_booked <= 0.6 and coworking_space.percentage_booked > 0.3
    }

    return list
  end

  def coworking_spaces_in_red_price(limit, city_id, category_id)
    list = []
    CoworkingSpace.limit(limit).all.each { |coworking_space|
      list << coworking_space if coworking_space.percentage_booked > 0.6
    }

    return list
  end
end
