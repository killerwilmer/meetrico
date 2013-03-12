# coding: utf-8
require File.dirname(__FILE__) + '/acceptance_helper'

feature "Home", %q{
  In order to know that I'm at the right page
  As a coworker
  I want to see a nice welcoming message
} do

  scenario "Welcome" do
    @utopicus = create_coworking_space
    visit("/")
    page.should have_content("Welcome to Metro Cúbico")
  end
  
end
