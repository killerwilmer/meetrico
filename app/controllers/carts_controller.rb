class CartsController < ApplicationController
  before_filter :authenticate_user!
  def new
    redirect_to root_path
  end
  
  def show
    @cart = current_cart
    
  end

  def remove_item
    @cart = current_cart

    @line_items = @cart.line_items
    @table = Table.find(params[:id])

    @line_items.where(:table_id => @table).first.destroy

    @reservations = Reservation.where(:table_id => @table, :user_id => current_user)

    @reservations.each do |reservation|
      reservation.destroy
    end
    
    redirect_to current_cart_url
  end

  def tickets
  end
end
