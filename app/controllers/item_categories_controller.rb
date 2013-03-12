class ItemCategoriesController < ApplicationController

  include ApplicationHelper

  before_filter :authenticate_admin!, :except => [:list]
  layout :choose_layout_all_profiles

  def index
    @item_categories = ItemCategory.all
  end

  def show
    @item_category = ItemCategory.find(params[:id])
  end

  def new
    @item_category = ItemCategory.new
  end

  def create
    @item_category = ItemCategory.new(params[:item_category])
    if @item_category.save
      redirect_to @item_category, :notice => "Successfully created item category."
    else
      render :action => 'new'
    end
  end

  def edit
    @item_category = ItemCategory.find(params[:id])
  end

  def update
    @item_category = ItemCategory.find(params[:id])
    if @item_category.update_attributes(params[:item_category])
      redirect_to @item_category, :notice  => "Successfully updated item category."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @item_category = ItemCategory.find(params[:id])
    @item_category.destroy
    redirect_to item_categories_url, :notice => "Successfully destroyed item category."
  end

  def list
    @promos = ItemCategory.all
    @contact_message = ContactMessage.new

    #@coworking_space = CoworkingSpace.find(params[:coworking_space_id]);
    #@item_category = ItemCategory.find(params[:id])
    #
    #@tables = @item_category.tables.where(:coworking_space_id => @coworking_space)
    #@tables = @tables.paginate(:page => params[:page]).order('created_at DESC')
    #
    #respond_to do |format|
    #  format.html { render :layout => false }
    #end
  end


  def by_coworking_space

    @coworking_space = CoworkingSpace.find(params[:coworking_space_id]);
    @item_categories = @coworking_space.item_categories if @coworking_space

    respond_to do |format|
      format.html { render :layout => false }
      format.xml { render :xml => @item_categories }
      format.json { render :json => @item_categories }
    end
  end
end
