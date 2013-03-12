class ReservationsController < InheritedResources::Base
  include ApplicationHelper

  before_filter :authenticate_user!, :only => [:new, :create]
  before_filter :authenticate_owner_or_admin, :only => [:index, :edit]

  layout :choose_layout_all_profiles
  
  def new
    @table = Table.find(params[:table_id]) 
    @user = current_user

    if @table.tipo == "ticket" and not @table.booked?
      activity = Activity.find(params[:activity_id])

      same_user_reservations = Reservation.joins(:user, :table).where(' reservations.user_id = ? and reservations.table_id in (select table_id from activity_tables where activity_id = ?) and reservations.user_id not in (select user_id from coworking_spaces where id in (select coworking_space_id from activities where id = ?))', current_user, activity.id, activity.id)
      if same_user_reservations.count <= 1
        @reservation = Reservation.create :table => @table, :duration => activity.duration,
          :user => @user, :end_time => activity.end_date, :start_time => activity.start_date,
          :state => State.find(1)

        Notification.reservation_request(@reservation).deliver
        redirect_to activity_path(activity),
          :notice => "Has solicitado reservar el cupo #{@reservation.table.name} de las #{@reservation.start_time.strftime("%H:%M")}h a las #{@reservation.end_time.strftime("%H:%M")}h"
      else
        flash[:notice] = "El usuario: \"#{@user.email}\" ha reservado 2 o mas plazas para la actividad: #{activity.name}"
        redirect_to activity_path(activity)
      end
      
    elsif @table.tipo == "resource" and not @table.reserved?

      new!
    else
      new!
      #else
      #flash[:notice] = "El producto: \"#{@table.name}\" se encuentra reservado por lo tanto no esta disponible"
      #redirect_to root_url
    end
    
  end
  
  def create
    @user = User.find(params[:reservation][:user_id])
    @user.update_attribute(:bio, params[:user][:bio])
    @table = Table.find(params[:reservation][:table_id])
    @unit_price = @table.item_category.price(@table.coworking_space)

    create! do |format|
      format.html {
        @table = @reservation.table
        @cart = current_cart

        @line_item = nil
        if @table.tipo == 'resource'
          @line_item = LineItem.create!(:cart => current_cart,
            :table => @table,
            :quantity => 1,
            :unit_price => @unit_price)
        elsif @table.tipo == 'ticket'
          @line_item = LineItem.create!(:cart => current_cart,
            :table => @table,
            :quantity => 1,
            :unit_price => @table.activities.first.price)
        end

        session[:cart_id] = @line_item.cart.id
        @cart = current_cart

        Notification.reservation_request(@reservation).deliver
        redirect_to coworking_space_path(@reservation.table.coworking_space),
        :notice => "Has solicitado reservar la mesa #{@reservation.table.name} de las #{@reservation.start_time.strftime("%H:%M")}h a las #{@reservation.end_time.strftime("%H:%M")}h"
      }
    end
  end

  def edit
    #try current_user.owner?
    #{"utf8"=>"✓",
    #"authenticity_token"=>"k92dKKJ64p7RsUdeaNjoUy37z5pBH+c9dQw20VWfRh0=",
    #"attempt"=>{"init_date"=>"2011-10-26 ", "init_time"=>"20:00"},
    #"reservation"=>{
    # "duration"=>"2",
    # "start_time"=>"2011-10-26 20:00:00",
    # "table_id"=>"282",
    # "user_id"=>"2",
    # "state_id"=>"4"},
    # "user"=>{"bio"=>"decs"}, "commit"=>"Actualizar reserva", "id"=>"75"}

    @reservation = Reservation.find(params[:id])
    @table = @reservation.table
    @user = @reservation.user
      
    if( (current_user.try(:owner?) or admin_signed_in? ) and @table.item_category)
      edit!
    elsif !@table.item_category || !ItemCategory.find(@table.item_category)
      flash[:notice] = "La linea de producto asociada al producto: #{@table.name} en el espacio: #{@table.coworking_space.name} no existe, por favor revise la configuracion del producto"
      redirect_to admins_path
    else
      redirect_to admins_path
    end
  end

  def update
    if current_user.try(:owner?) or admin_signed_in?
      @reservation = Reservation.find(params[:id])
      
      @table = @reservation.table
      @user = @reservation.user

      @state = params[:reservation][:state_id]
      if @state == "4"        
        @table.update_attribute(:booked, false)
        @reservation.destroy
        redirect_to reservations_path, :state => "solicitada"
      else
        update!
      end
    else
      redirect_to admins_path
    end
  end
  
  def reset
    User.delete_all
    Authentication.delete_all
    Reservation.delete_all
    Table.all.each {|t| t.update_attribute(:booked, false)}
    redirect_to root_url
  end

  def index
    @list_requests = params[:state]

    @coworking_spaces = nil
    if current_user.try(:owner?)      
      @coworking_spaces = CoworkingSpace.where :user_id => current_user

    end

    @reservations = Reservation.paginate(:page => params[:page]).order('start_time desc').all if params[:state].nil? and admin_signed_in?
    @reservations = Reservation.paginate(:page => params[:page]).where(:state_id => '1').order('start_time desc') if @list_requests == "solicitada"
    @reservations = Reservation.paginate(:page => params[:page]).joins(:table).where(:tables => {:coworking_space_id => @coworking_spaces}).order('start_time desc') if current_user.try(:owner?)

    
    
    render  :layout => choose_layout
       
  end

  def list
    @coworking_space = CoworkingSpace.find(params[:coworking_space_id])
    @reservations = (Reservation.where :table_id => @coworking_space.tables.where('tipo = ?', 'resource')).active
    events = []

    @reservations.each do |res|
      temp = {:id => res.id,
        :name => res.start_time.strftime("%H:%M")+", item: "+res.table.name.to_s+", por :"+res.user.name,
        :title => res.start_time.strftime("%H:%M")+", item: "+res.table.name.to_s+", por :"+res.user.name,
        :start => res.start_time.strftime("%Y-%m-%d %H:%M:%S"),
        :end => res.end_time.strftime("%Y-%m-%d %H:%M:%S"),
        :url => "/reservations/"+res.id.to_s
      }
      #p temp.inspect
      events << temp

    end
    respond_to do |format|
      format.html {
        render :layout => params[:layout] if params[:layout]
      }
      format.xml { render :xml => events }
      format.json { render :json => events }
    end
  end

  def aprove
    salt_and_pepper = Metrocubico::Application.config.salt_and_pepper
    
    @reservation = Reservation.find(params[:id])
    if not @reservation.nil? and @reservation.state.id = 1
      @hash = Digest::MD5.hexdigest(@reservation.id.to_s+@reservation.table.id.to_s+@reservation.user.email+salt_and_pepper)
      Notification.paypal_link(@reservation, @hash).deliver
      @reservation.state = State.find(2)
      @reservation.save
    else
      flash[:notice] = "Esta reserva no esta activa o ha sido procesada erroneamente"
      redirect_to root_url
    end
    

    redirect_to :controller => :reservations, :action => :index, :state => 'solicitada'
  end

  def paylink

    @reservation = Reservation.find(params[:id])

    salt_and_pepper = Metrocubico::Application.config.salt_and_pepper
    @home_hash = Digest::MD5.hexdigest(@reservation.id.to_s+@reservation.table.id.to_s+@reservation.user.email+salt_and_pepper)
    @foreing_hash = params[:hash]
    
    @cart = current_cart

    @line_item = nil
    @line_item = LineItem.where(:cart_id => @cart.id).first

    session[:cart_id] = @line_item.cart.id
    @cart = current_cart
    
    unless @home_hash == @foreing_hash or @line_item.nil?
      flash[:alert] = "Reconduce tu compra por el camino adecuado."
      redirect_to root_url
    end

    flash[:notice] = "Ya puedes pagar por tu reserva ;)"
        
  end

  def payment
    @reservation = Reservation.find(params[:id])

    if not @reservation.nil? and @reservation.state.id = 2
      @reservation.state = State.find(3)
      @reservation.save
    else
      flash[:notice] = "Esta reserva no esta activa o ha sido procesada erroneamente"
      redirect_to root_url
    end
    flash[:notice] = "Se ha registrado el pago por la reserva"
    redirect_to reservations_url
  end

  def actives
    @user = User.find params[:user_id]
    @reservations = nil
    if @user
      @reservations = Reservation.where("user_id = ? ", @user.id).active
    end
  end

  def liberate

    @reservations = Reservation.where('end_time < ?', DateTime.now)
    @booked_but_not_reserved = Table.where('tables.id not in (select table_id from reservations) and tables.booked = ?', true)
    count = 0
    @reservations.each do |r|
      #t.booked = false
      #t.save
      if r.table
        r.table.booked = false
        r.table.save
        #p r.table.inspect
        count+=1
      end

      r.destroy
    end

    @booked_but_not_reserved.each do |t|
      t.booked = false
      t.save
      count+=1
    end




    @message = {}
    @message.store("success", "true")
    @message.store("message", "Se liberar&oacute;n "+count.to_s+" productos o cupos")

    respond_to do |format|
      format.html {
        redirect_to root_url
      }
      format.xml { }
      format.json { 
        render :json => @message
      }
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id]) rescue nil

    if @reservation
      
      if @reservation.table
        @reservation.table.booked = false
        @reservation.table.save
      end

      @reservation.destroy
    end

    flash[:notice] = "Se ha eliminado la reserva correctamente."
    redirect_to reservations_url
    
  end
  

  private
  

  def choose_layout
    return 'owners' if current_user.try(:owner?)
    return 'admin' if admin_signed_in?
  end
end
