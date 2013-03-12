# coding: utf-8
module HelperMethods
  def login_as(user)
    visit "users/sign_in"
    fill_in "Email", :with => user.email
    fill_in "Contraseña", :with => "secret"
    click_button "Acceder"
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance
