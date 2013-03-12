require "spec_helper"

describe CoworkingSpacesController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/coworking_spaces" }.should route_to(:controller => "coworking_spaces", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/coworking_spaces/new" }.should route_to(:controller => "coworking_spaces", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/coworking_spaces/1" }.should route_to(:controller => "coworking_spaces", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/coworking_spaces/1/edit" }.should route_to(:controller => "coworking_spaces", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/coworking_spaces" }.should route_to(:controller => "coworking_spaces", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/coworking_spaces/1" }.should route_to(:controller => "coworking_spaces", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/coworking_spaces/1" }.should route_to(:controller => "coworking_spaces", :action => "destroy", :id => "1")
    end

  end
end
