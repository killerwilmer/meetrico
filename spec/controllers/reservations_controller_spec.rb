require 'spec_helper'

describe ReservationsController do

  def mock_reservation(stubs={})
    (@mock_reservation ||= mock_model(Reservation).as_null_object).tap do |reservation|
      reservation.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all reservations as @reservations" do
      Reservation.stub(:all) { [mock_reservation] }
      get :index
      assigns(:reservations).should eq([mock_reservation])
    end
  end

  describe "GET show" do
    it "assigns the requested reservation as @reservation" do
      Reservation.stub(:find).with("37") { mock_reservation }
      get :show, :id => "37"
      assigns(:reservation).should be(mock_reservation)
    end
  end

  describe "GET new" do
    it "assigns a new reservation as @reservation" do
      Reservation.stub(:new) { mock_reservation }
      get :new
      assigns(:reservation).should be(mock_reservation)
    end
  end

  describe "GET edit" do
    it "assigns the requested reservation as @reservation" do
      Reservation.stub(:find).with("37") { mock_reservation }
      get :edit, :id => "37"
      assigns(:reservation).should be(mock_reservation)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created reservation as @reservation" do
        Reservation.stub(:new).with({'these' => 'params'}) { mock_reservation(:save => true) }
        post :create, :reservation => {'these' => 'params'}
        assigns(:reservation).should be(mock_reservation)
      end

      it "redirects to the created reservation" do
        Reservation.stub(:new) { mock_reservation(:save => true) }
        post :create, :reservation => {}
        response.should redirect_to(reservation_url(mock_reservation))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved reservation as @reservation" do
        Reservation.stub(:new).with({'these' => 'params'}) { mock_reservation(:save => false) }
        post :create, :reservation => {'these' => 'params'}
        assigns(:reservation).should be(mock_reservation)
      end

      it "re-renders the 'new' template" do
        Reservation.stub(:new) { mock_reservation(:save => false) }
        post :create, :reservation => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested reservation" do
        Reservation.should_receive(:find).with("37") { mock_reservation }
        mock_reservation.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :reservation => {'these' => 'params'}
      end

      it "assigns the requested reservation as @reservation" do
        Reservation.stub(:find) { mock_reservation(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:reservation).should be(mock_reservation)
      end

      it "redirects to the reservation" do
        Reservation.stub(:find) { mock_reservation(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(reservation_url(mock_reservation))
      end
    end

    describe "with invalid params" do
      it "assigns the reservation as @reservation" do
        Reservation.stub(:find) { mock_reservation(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:reservation).should be(mock_reservation)
      end

      it "re-renders the 'edit' template" do
        Reservation.stub(:find) { mock_reservation(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested reservation" do
      Reservation.should_receive(:find).with("37") { mock_reservation }
      mock_reservation.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the reservations list" do
      Reservation.stub(:find) { mock_reservation }
      delete :destroy, :id => "1"
      response.should redirect_to(reservations_url)
    end
  end

end
