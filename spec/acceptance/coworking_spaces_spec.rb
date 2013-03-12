# coding: utf-8
require File.dirname(__FILE__) + '/acceptance_helper'

feature "Coworking Spaces", %q{
  In order to manage coworking spaces
  As a coworking space owner
  I want to create a coworking space
} do
  
  background do
    @utopicus = create_coworking_space
  end

  scenario "Create a coworking space" do
    visit("/coworking_spaces/new")
    
    fill_in "Name", :with => "Utopicus"
    select  "6", :from => "Number of tables"
    fill_in "Green", :with => 3
    fill_in "Yellow", :with => 6
    fill_in "Red", :with => 9
    click_button "Create Coworking space"
    
    page.should have_content "Coworking space was successfully created."

    utopicus = CoworkingSpace.last
    utopicus.name.should == "Utopicus"
    utopicus.green.should == 3
    utopicus.yellow.should == 6
    utopicus.red.should == 9
    utopicus.tables.count.should == 6
  end
  
  context "Reserved table" do
    scenario "Someone has reserved a table" do
      
      ana = create_user(:name => "Ana", :bio => "Soy Filosofa")
      table = @utopicus.tables[1]
      create_reservation(:user_id => ana.id, :table_id => table.id)
      
      rafa = create_user(:name => "Rafa")
      login_as(rafa)
      
      visit "coworking_spaces/#{@utopicus.id}"

      page.should have_css("#table_#{table.id}.reserved")

      within("#table_#{table.id}") do
        page.should have_css(".avatar img[@src='#{ana.avatar}']")
        page.should have_css(".name", :text => "Ana")
        page.should have_css(".bio", :text => "Soy Filosofa")
        page.should_not have_content("Reservar")
      end
    end
    
    scenario "You have reserved a table" do      
      ana = create_user(:name => "Ana", :bio => "Soy Filosofa")
      table = @utopicus.tables[1]
      create_reservation(:user_id => ana.id, :table_id => table.id)
      
      login_as(ana)
      click_link "Utopicus"

      page.should have_css("#table_#{table.id}.reserved.current")

      within("#table_#{table.id}") do
        page.should have_css(".avatar img[@src='#{ana.avatar}']")
        page.should have_css(".name", :text => "Ana")
        page.should have_content("Tu mesa")
        page.should have_css(".bio", :text => "Soy Filosofa")
        page.should_not have_content("Reservar")
      end
    end
    
    scenario "Reservation is over" do      
      ana = create_user(:name => "Ana", :bio => "Soy Filosofa")
      table = @utopicus.tables[1]
      create_reservation(:user_id => ana.id, :table_id => table.id, :duration => 1)
      
      login_as(ana)
      click_link "Utopicus"

      page.should have_css("#table_#{table.id}.reserved.current")

      Delorean.time_travel_to(2.hours.from_now)
      
      visit "coworking_spaces/#{@utopicus.id}"
      page.should_not have_css("#table_#{table.id}.reserved.current")
    end
  end
  
end
