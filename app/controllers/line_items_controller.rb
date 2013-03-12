class LineItemsController < ApplicationController

  
  
  def create
#    @product = Product.find(params[:product_id])
#    @line_item = LineItem.create!(:cart => current_cart, :product => @product, :quantity => 1, :unit_price => @product.price)
#    flash[:notice] = "Added #{@product.name} to cart."

    @table = Table.find(params[:table_id])
    @line_item = LineItem.create!(:cart => current_cart, :table => @table, :quantity => 1, :unit_price => @table.coworking_space.price )
    redirect_to current_cart_url
  end
end
