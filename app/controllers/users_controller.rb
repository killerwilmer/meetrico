class UsersController < InheritedResources::Base

  include ApplicationHelper
  #before_filter :authenticate_user!, :only => [:owner_home, :edit, :update]
  before_filter :authenticate_admin!, :only => [:index]
  layout :choose_layout_all_profiles
  
  def owner_home    
  end

  def index
    @users = User.paginate(:page => params[:page]).order('created_at desc').all
  end

  
  def list_owners
    #super
    @users = User.where :owner => true    
  end

  def search_by_name
    @users = User.where("name iLIKE ?", '%'+params[:term]+'%')
    @users_json = @users.to_json

    respond_to do |format|
      format.html {render :layout=>false}
      format.xml  { head :ok }
      format.json {render :json => @users_json, :layout=>false}
    end
  end

  def edit
    @user = User.find(params[:id])

    if @user != current_user and not admin_signed_in?
      flash[:notice] = "Unicamente el propio usuario puede editar su datos"
      redirect_to root_url
    end
  end

  def set_profile
    @user = User.find params[:id]
    @new_profile = params[:type]
    if @user and @new_profile != ''
      case @new_profile
      when 'propietario'
        @user.owner = true

      when 'usuario'
        @user.owner = false

      end

      @user.save
    end

    redirect_to users_path
  end

  def delete
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @coworking_spaces = nil

    @coworking_spaces = CoworkingSpace.where :user_id => @user

    
    if @coworking_spaces.length <= 0
      @user.destroy
      flash[:notice] = "Usuario eliminado satisfactoriamente"
      redirect_to users_path
    else
      flash[:notice] = "No se elimina el usuario: "+@user.name+" debido a que esta asociado a "+@coworking_spaces.length.to_s+" espacio(s)"
      redirect_to users_path
    end
  end
  #  def update
  #    @user = User.find(params[:id])
  #    if @user
  #
  #    end
  #
  #
  #    redirect_to @user
  #  end

  def choose_layout
    return 'owners' if params[:action] == "owner_home"
    return 'application' if not params[:action] == "owner_home" and admin_
    return 'admin'
  end
end
