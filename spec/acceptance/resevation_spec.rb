# coding: utf-8
require File.dirname(__FILE__) + '/acceptance_helper'

feature "Reservation", %q{
  In order to work at cool coworking spaces
  As a worker
  I want to reserve a table in a coworking space
} do

  background do
    @utopicus = create_coworking_space(:number_of_tables => 10)
    rafa = create_user(:name => "Rafa")
    login_as(rafa)
  end
  
  scenario "Make a reservation" do
    visit "coworking_spaces/#{@utopicus.id}"
    
    table = @utopicus.tables.first
    click_link("Reservar")
     
    page.should have_content("Reserva para la mesa #{table.name}")
    
    select "2", :from => "Duration"
    fill_in "Bio", :with => "Soy Isabel escultura"
    click_button("Create Reservation")

    page.should have_content("Reserva realizada correctamente.")
    
    Reservation.count.should == 1
    reservation = Reservation.first
    reservation.table.should == table 
    
    reservation.user.email.should == "rafa@example.com"
    #calculate starting time
    #reservation.start_time.strftime("%H:%M").should == "18:00"
    reservation.duration.should == 2
    reservation.user.bio = "Soy Isabel escultura"
    
    reservation.table.booked.should be_true
  end
  
  context "Next available hour" do
    scenario "No previous reservations" do
      visit "coworking_spaces/#{@utopicus.id}"
      
      table = @utopicus.tables.first

      click_link("Reservar")
      
      page.should have_content("La reserva comenzará a las #{(Time.now + 1.hour).strftime("%H:00") }h")
    end
  end
  
  scenario "Reservation duration" do
    visit "coworking_spaces/#{@utopicus.id}"
    
    table = @utopicus.tables.first

    click_link("Reservar")
    
    select "2", :from => "reservation_duration"
    click_button("reservation_submit")
    
    reservation = Reservation.last

    page.should have_content("Has reservado la mesa #{table.name} de las #{reservation.start_time.strftime("%H:00")} a las #{reservation.end_time.strftime("%H:00")}")
  end
  
  
end