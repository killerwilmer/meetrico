require "spec_helper"

describe ReservationsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/reservations" }.should route_to(:controller => "reservations", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/reservations/new" }.should route_to(:controller => "reservations", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/reservations/1" }.should route_to(:controller => "reservations", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/reservations/1/edit" }.should route_to(:controller => "reservations", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/reservations" }.should route_to(:controller => "reservations", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/reservations/1" }.should route_to(:controller => "reservations", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/reservations/1" }.should route_to(:controller => "reservations", :action => "destroy", :id => "1")
    end

  end
end
