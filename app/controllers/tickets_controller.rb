class TicketsController < ApplicationController
  
  include ApplicationHelper
  include ActivitiesHelper
  include TicketsHelper
  
  before_filter :authenticate_owner_or_admin, :only => [:edit, :update, :index, :delete]
  before_filter :authenticate_user!, :only => [:new, :create]
  layout :choose_layout_all_profiles
  
  
  def index
    @activity = Activity.find(params[:activity_id])
    @reservation = Reservation.find(params[:reservation_id])
    @tickets = Ticket.paginate(:page => params[:page]).order('created_at desc').where(:activity_id => @activity, :reservation_id => @reservation)
    
    respond_to do |format|
      format.html
      format.xml
      format.json
    end
    
  end
  
  
  def new
    @activity = Activity.find(params[:activity_id])
    @reservation = Reservation.find(params[:reservation_id])
    @user = current_user
    
    @table = @activity.table
    @unit_price = @activity.price
    
    @cart = current_cart
    
    @line_item = LineItem.create!(:cart => current_cart, :table => @table, :quantity => 1,:unit_price => @unit_price)
    
    session[:cart_id] = @line_item.cart.id
    @cart = current_cart
    
    @ticket = Ticket.create!(:cart => @cart, :activity => @activity, :user => current_user, :state => State.find(1), :reservation => @reservation)
    
    respond_to do |format|
      format.html
      format.xml
      format.json
    end
    
  end
  
  def edit
    @activity = Activity.find(params[:activity_id])
    @reservation = Reservation.find(params[:reservation_id])
    @ticket = Ticket.find(params[:id])

    
  end

  def update
    @activity = Activity.find(params[:activity_id])
    @reservation = Reservation.find(params[:reservation_id])
    @ticket = Ticket.find(params[:id])

    attrs = params[:ticket] || {}
    step = @ticket.state.id
    next_step = attrs[:state_id]
    
    if @ticket.update_attributes(attrs)
      process_it(@ticket, step, next_step)
    end
    
    redirect_to activity_reservation_tickets_url(@activity, @reservation)
  end
  
  def create
    
    respond_to do |format|
      format.html
      format.xml
      format.json
    end
    
  end
end
