class CoworkingSpacesController < InheritedResources::Base

  #layout 'admin', :except => [:new, :show]
  #layout 'application', :only => [:show]
  
  #layout 'admin', :only => [:index, :new]
  include ApplicationHelper
  include CoworkingSpacesHelper

  layout :choose_layout_all_profiles

  before_filter :authenticate_owner_or_admin, :except => [:show, :list, :query]
  
  def index
    list
  end
  
  def list
    
    @coworking_spaces = CoworkingSpace.all
    @user = current_user
    if current_user.try(:owner?)
      @coworking_spaces = CoworkingSpace.where :user_id =>  @user
    end
       
    respond_to do |format|
      format.html {
        render :layout => params[:layout] if params[:layout]
      }
      format.xml { render :xml => @coworking_spaces }
      format.json { render :json => @coworking_spaces }
    end
  end

  def query
    
    limit = params[:limit]
    price = params[:precio]
    category_id = params[:category_id]
    list = []  
    
    list = coworking_spaces_all_prices(limit, price, category_id)
    
    respond_to do |format|
      format.html {
        render :layout => false
      }
      format.xml { render :xml => list }
      format.json { render :json => list }
    end

    
  end

  def new
    @coworking_space = CoworkingSpace.new 
    
  end

  #  def update
  #    #{"utf8"=>"✓",
  #    #"authenticity_token"=>"hEANR2sG//LTrpJ+CoxB7DzfokKFCOiJQ6vW9x5mjJU=",
  #    #"coworking_space"=>{
  #    # "name"=>"Empresarial Europea",
  #    # "number_of_tables"=>"1",
  #    # "green"=>"50",
  #    # "yellow"=>"30",
  #    # "red"=>"10",
  #    # "lat"=>"40.4272",
  #    # "long"=>"-3.6944",
  #    # "plan_image"=>
  #    #   ActionDispatch::Http::UploadedFile:0xaf640c8
  #    #     @original_filename="empresarial2.png",
  #    #     @content_type="image/png",
  #    #     @headers="
  #    #         Content-Disposition: form-data;
  #    #         name=\"coworking_space[plan_image]\";
  #    #         filename=\"empresarial2.png\"\r\nContent-Type: image/png\r\n",
  #    #         @tempfile=File:/tmp/RackMultipart20110915-8734-1kkzoxi>>
  #    # "city_id"=>"2",
  #    # "user_id"=>"2"},
  #    #"user_name"=>"",
  #    #"commit"=>"Actualizar Coworking space",
  #    #"id"=>"2"}
  #    @coworking_space = CoworkingSpace.find params[:id]
  #
  #    @coworking_space.save
  #
  #    redirect_to @coworking_space
  #  end

  def create
    @coworking_space = CoworkingSpace.create(params[:coworking_space])
    
    @lines = params[:lines]

    if !@lines.nil? && @lines.length > 0
      @lines.each do |line|
        line_id = line[0]
        config = line[1]
        item_category_cws = ItemCategoriesCoworkingSpace.create :coworking_space_id => @coworking_space.id,
          :item_category_id => line_id.to_i,
          :num_tables => (config[:num_tables]).to_i,
          :available => (config[:available]).to_i,
          :green => (config[:green]).to_i,
          :yellow => (config[:yellow]).to_i,
          :red => (config[:red]).to_i
      end
    end
    
    respond_to do |format|
      format.html { }
      format.json { render :json => data.to_json }
    end
  end

  def update
    @coworking_space = CoworkingSpace.find params[:id]

    @num_tables = @coworking_space.tables.count.to_i
    previous = ItemCategoriesCoworkingSpace.where(:coworking_space_id => @coworking_space.id)
    if previous.length > 0
      previous.each do |ic_cws|
        ic_cws.destroy
      end
    end
    #
    
    if @coworking_space.update_attributes(params[:coworking_space])     

      if ((params[:coworking_space][:number_of_tables]).to_i != @num_tables = @coworking_space.tables.count.to_i)
        current_tables = Table.joins(:reservations).where('tables.id in (?) and end_time > ? and state_id in (\'1\', \'2\', \'3\')',
          @coworking_space.tables, DateTime.now )

        current_tables = current_tables.to_a
        all_tables = @coworking_space.tables.to_a
        tables_to_delete = all_tables - current_tables

        
        tables_to_delete.each do |table|
          table.destroy
        end

        @lines = params[:lines]

        if !@lines.nil? && @lines.length > 0
          @lines.each do |line|
            line_id = line[0]
            config = line[1]
            item_category_cws = ItemCategoriesCoworkingSpace.create :coworking_space_id => @coworking_space.id,
              :item_category_id => line_id.to_i,
              :num_tables => (config[:num_tables]).to_i,
              :available => (config[:available]).to_i,
              :green => (config[:green]).to_i,
              :yellow => (config[:yellow]).to_i,
              :red => (config[:red]).to_i
          end
        end

      end
      
      redirect_to @coworking_space, :notice  => "Successfully updated Coworking Space."
    else
      render :action => 'edit'
    end
    
  end

  def gallery
    @coworking_space = CoworkingSpace.find(params[:id])

    @images = @coworking_space.images

    respond_to do |format|
      format.html { }      
      format.json { render :json => @images }
    end
  end

  def search_by_name
    @coworking_spaces = CoworkingSpace.where(" name ilike '%"+params[:term]+"%'")
    respond_to do |format|
      format.html { }
      format.json { render :json => @coworking_spaces }
    end
  end

  def edit
    @coworking_space = CoworkingSpace.find(params[:id])
    
  end


  def delete
    @coworking_space = CoworkingSpace.find(params[:id])
  end

  def destroy
    @coworking_space = CoworkingSpace.find(params[:id])

    @reservations = nil

    @reservations = Reservation.joins(:table).where(:tables => {:coworking_space_id => @coworking_space})

    
    
    if @reservations.length <= 0
      @coworking_space.tables.each do |t|
        t.destroy
      end
      @coworking_space.destroy
      flash[:notice] = "Espacio eliminado satisfactoriamente"      
    else
      flash[:notice] = "No se elimina el espacio "+@coworking_space.name+
        " debido a que esta asociado a "+@reservations.length.to_s+" reservas(s)"
    end

    redirect_to coworking_spaces_path
  end

  def show
    @coworking_space = CoworkingSpace.find(params[:id])
    @contact_message = ContactMessage.new

    respond_to do |format|
      format.html { render :layout => "application"}
      format.json { render :json => @coworking_space }
    end
  end

  private

  
  def choose_layout
    return 'application' if params[:action] == "show"
    return 'owners' if current_user.try(:owner?)
    return 'admin' if admin_signed_in?
  end

  
end
