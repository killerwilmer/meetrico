require 'spec_helper'

describe CoworkingSpacesController do

  def mock_coworking_space(stubs={})
    (@mock_coworking_space ||= mock_model(CoworkingSpace).as_null_object).tap do |coworking_space|
      coworking_space.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all coworking_spaces as @coworking_spaces" do
      CoworkingSpace.stub(:all) { [mock_coworking_space] }
      get :index
      assigns(:coworking_spaces).should eq([mock_coworking_space])
    end
  end

  describe "GET show" do
    it "assigns the requested coworking_space as @coworking_space" do
      CoworkingSpace.stub(:find).with("37") { mock_coworking_space }
      get :show, :id => "37"
      assigns(:coworking_space).should be(mock_coworking_space)
    end
  end

  describe "GET new" do
    it "assigns a new coworking_space as @coworking_space" do
      CoworkingSpace.stub(:new) { mock_coworking_space }
      get :new
      assigns(:coworking_space).should be(mock_coworking_space)
    end
  end

  describe "GET edit" do
    it "assigns the requested coworking_space as @coworking_space" do
      CoworkingSpace.stub(:find).with("37") { mock_coworking_space }
      get :edit, :id => "37"
      assigns(:coworking_space).should be(mock_coworking_space)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created coworking_space as @coworking_space" do
        CoworkingSpace.stub(:new).with({'these' => 'params'}) { mock_coworking_space(:save => true) }
        post :create, :coworking_space => {'these' => 'params'}
        assigns(:coworking_space).should be(mock_coworking_space)
      end

      it "redirects to the created coworking_space" do
        CoworkingSpace.stub(:new) { mock_coworking_space(:save => true) }
        post :create, :coworking_space => {}
        response.should redirect_to(coworking_space_url(mock_coworking_space))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved coworking_space as @coworking_space" do
        CoworkingSpace.stub(:new).with({'these' => 'params'}) { mock_coworking_space(:save => false) }
        post :create, :coworking_space => {'these' => 'params'}
        assigns(:coworking_space).should be(mock_coworking_space)
      end

      it "re-renders the 'new' template" do
        CoworkingSpace.stub(:new) { mock_coworking_space(:save => false) }
        post :create, :coworking_space => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested coworking_space" do
        CoworkingSpace.should_receive(:find).with("37") { mock_coworking_space }
        mock_coworking_space.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :coworking_space => {'these' => 'params'}
      end

      it "assigns the requested coworking_space as @coworking_space" do
        CoworkingSpace.stub(:find) { mock_coworking_space(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:coworking_space).should be(mock_coworking_space)
      end

      it "redirects to the coworking_space" do
        CoworkingSpace.stub(:find) { mock_coworking_space(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(coworking_space_url(mock_coworking_space))
      end
    end

    describe "with invalid params" do
      it "assigns the coworking_space as @coworking_space" do
        CoworkingSpace.stub(:find) { mock_coworking_space(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:coworking_space).should be(mock_coworking_space)
      end

      it "re-renders the 'edit' template" do
        CoworkingSpace.stub(:find) { mock_coworking_space(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested coworking_space" do
      CoworkingSpace.should_receive(:find).with("37") { mock_coworking_space }
      mock_coworking_space.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the coworking_spaces list" do
      CoworkingSpace.stub(:find) { mock_coworking_space }
      delete :destroy, :id => "1"
      response.should redirect_to(coworking_spaces_url)
    end
  end

end
