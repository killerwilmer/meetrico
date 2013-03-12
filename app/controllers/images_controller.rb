class ImagesController < ApplicationController
  include ApplicationHelper
  
  before_filter :authenticate_owner_or_admin
  layout :choose_layout_all_profiles
  
  def index
    @images = Image.all
  end

  def show
    @image = Image.find(params[:id])
  end

  def new
    @image = Image.new
    @type = params[:type]
    @id = params[:id]
    @resource = nil
    unless @type.nil? and @id.nil?
      case @type
      when 'coworking_space'
        @resource = CoworkingSpace.find(@id)
      when 'table'
        @resource = Table.find(@id)
      end
    end

  end


  def create
    @image = Image.new(params[:image])
    @type = params[:type] if not params[:type].nil? and params[:type] != ''
    @id = params[:id] if not params[:id].nil? and params[:id] != ''
    @resource = nil
    if @image.save
      unless @type.nil? and @id.nil?
        case @type
        when 'coworking_space'
          @resource = CoworkingSpace.find(@id)
          image_cws = ImageCoworkingSpace.create :coworking_space => @resource, :image => @image

        when 'table'
          @resource = Table.find(@id)
          image_table = ImageTable.create :table => @resource, :image => @image
        end
      end
      
      flash[:notice] = "Successfully created image."
      redirect_to :controller => :images, :action => :new, :type => @type, :id => @id
    else
      render :action => 'new'
    end
  end

  def edit
    @image = Image.find(params[:id])
  end

  def update
    @image = Image.find(params[:id])
    if @image.update_attributes(params[:image])
      redirect_to @image, :notice  => "Successfully updated image."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy
    redirect_to images_url, :notice => "Successfully destroyed image."
  end

end
