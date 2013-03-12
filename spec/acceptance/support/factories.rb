module FactoryMethods
  def create_user(attrs = {})
    attrs[:name] ||= "Ana#{rand(9999)}"
    attrs[:email] ||= "#{attrs[:name]}@example.com"
    attrs[:password] ||= "secret"
    attrs[:password_confirmation] ||= "secret"
    attrs[:avatar] ||= "http://graph.facebook.com/7106254/picture?type=square"
    attrs[:bio] ||= "Soy yonki"
    User.create!(attrs)
  end
  
  def create_reservation(attrs = {})
    attrs[:user_id] ||= create_user.id
    attrs[:duration] ||= 5
    Reservation.create!(attrs)
  end
  
  def create_coworking_space(attrs = {})
    attrs[:name] ||= "Utopic_US"
    attrs[:number_of_tables] ||= 10
    attrs[:green] ||= 3
    attrs[:yellow] ||= 6
    attrs[:red] ||= 9
    CoworkingSpace.create!(attrs)
  end

end

RSpec.configuration.include FactoryMethods, :type => :acceptance