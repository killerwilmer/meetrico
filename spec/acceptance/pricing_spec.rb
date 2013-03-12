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
  
  scenario "less than 30% full" do
    3.times do |i| 
      create_reservation(:table_id => @utopicus.tables[i].id)
    end
    
    visit "coworking_spaces/#{@utopicus.id}"
    
    page.should have_css("#thermometer.green")
   
    within("#thermometer") do
      page.should have_css(".green.active", :text => "3")
      page.should_not have_css(".yellow.active", :text => "6")
      page.should_not have_css(".red.active", :text => "9")
    end
  end
  
  scenario "between 30% and 60% full" do
    6.times do |i|             
      create_reservation(:table_id => @utopicus.tables[i].id)
    end
    
    visit "coworking_spaces/#{@utopicus.id}"
    
    page.should have_css("#thermometer.yellow")
   
    within("#thermometer") do
      page.should_not have_css(".green.active", :text => "3")
      page.should have_css(".yellow.active", :text => "6")
      page.should_not have_css(".red.active", :text => "9")
    end
  end
  
  scenario "more than 60% full" do
    9.times do |i|
      create_reservation(:table_id => @utopicus.tables[i].id)
    end

    visit "coworking_spaces/#{@utopicus.id}"

    page.should have_css("#thermometer.red")
   
    within("#thermometer") do
      page.should_not have_css(".green.active", :text => "3")
      page.should_not have_css(".yellow.active", :text => "6")
      page.should have_css(".red.active", :text => "9")
    end
  end
  
  scenario "tables left at a given price" do
    page.should have_content("Quedan 2 mesas a...")
    create_reservation(:table_id => @utopicus.tables[0].id)

    visit "coworking_spaces/#{@utopicus.id}" 
  
    page.should have_content("Quedan 1 mesas a")
  
    create_reservation(:table_id => @utopicus.tables[1].id)
    visit "coworking_spaces/#{@utopicus.id}" 

    page.should have_content("Quedan 2 mesas a")

    create_reservation(:table_id => @utopicus.tables[2].id)
    visit "coworking_spaces/#{@utopicus.id}" 

    page.should have_content("Quedan 1 mesas a")
    
    create_reservation(:table_id => @utopicus.tables[3].id)
    visit "coworking_spaces/#{@utopicus.id}" 

    page.should have_content("Quedan 2 mesas a")

    create_reservation(:table_id => @utopicus.tables[4].id)
    visit "coworking_spaces/#{@utopicus.id}" 

    page.should have_content("Quedan 1 mesas a")
    create_reservation(:table_id => @utopicus.tables[5].id)
    visit "coworking_spaces/#{@utopicus.id}" 

    page.should have_content("No hay mesas disponibles")
  end
  

    
end