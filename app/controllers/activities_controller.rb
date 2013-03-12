class ActivitiesController < InheritedResources::Base
  include ApplicationHelper
  include ActivitiesHelper

  before_filter :authenticate_owner_or_admin, :only => [:new, :edit, :update, :index, :delete]
  layout :choose_layout_all_profiles
  
  def index
    @activities = Activity.paginate(:page => params[:page]).order('start_date desc').all unless current_user.try(:owner?) and admin_signed_in?
    @activities = Activity.paginate(:page => params[:page]).where("table_id in (select id from tables where coworking_space_id in (select id from coworking_spaces where user_id = '?'))", current_user).order('start_date desc') if current_user.try(:owner?) and not admin_signed_in?
  end

  def show
    @activity = Activity.find(params[:id]) rescue nil
    @next_available_table = nil
    if @activity
      render :layout => 'application'
    else
      redirect_to activities_url
    end
  end

  def new
    @activity = Activity.new
    @tables = []
    @item_categories = []
    @coworking_spaces = nil
    if admin_signed_in? and not current_user.try(:owner?) and not user_signed_in?
      @coworking_spaces = CoworkingSpace.all
    end

    if current_user.try(:owner?) and user_signed_in? and not admin_signed_in?
      @coworking_spaces = CoworkingSpace.where :user_id => current_user

      if @coworking_spaces.length < 1
        redirect_to owners_path, :notice  => "Este usuario no es propietario de ningun espacio, por lo tanto no puede crear actividades."
      end
    end
  end
  


  def create
    @activity = Activity.new(params[:activity])
    start_time = params[:activity][:start_date]+" "+params[:attempt][:init_time]

    @activity.start_date = start_time
    @table = Table.find(params[:options][:table_id])
    valid_dates_list = (params[:options][:valid_dates]).split(', ')
    @coworking_space = CoworkingSpace.find(params[:coworking_space][:id])

    @activity.num_available_tickets = @activity.num_tickets - @activity.num_owner_tickets
    @activity.table = @table

    if @activity.save
      valid_dates_list.each do |date|
        reservation = Reservation.create! :table => @table,
          :user => @coworking_space.user, :start_time => Time.parse(date),
          :state => State.find(3), :duration => @activity.duration,
          :recurrent => true
        ReservationsActivity.create! :activity => @activity, :reservation => reservation, :num_tickets => @activity.num_available_tickets
      end
      flash[:notice] = "Actividad creada exitosamente"
      redirect_to activity_url(@activity)
    else
      redirect_to new_activity_url
    end
    

  end

  def edit
    @activity = Activity.find(params[:id])
    #@activity.start_date = @activity.start_date.strftime("%Y-%m-%d")
    @tickets_total = @activity.tables.length

    separated_reservations =  Reservation.where :user_id => @activity.coworking_space.user, :table_id => @activity.coworking_space.tables
    @tickets_num_separados = separated_reservations.table.count
    @attempt_init_time = @activity.start_date.strftime("%H:%M")

    @coworking_spaces = CoworkingSpace.all if admin_signed_in? and not current_user.try(:owner?) and not user_signed_in?
    @coworking_spaces = CoworkingSpace.where :user_id => current_user if current_user.try(:owner?) and user_signed_in? and not admin_signed_in?
  end

  def update
    @activity = Activity.find(params[:id])
    params[:activity][:start_date] = params[:activity][:start_date]+" "+params[:attempt][:init_time]
    
    if @activity.update_attributes(params[:activity])

      #      current_tables = Table.joins(:reservations).where('tables.id in (?) and end_time > ? and state_id in (\'1\', \'2\', \'3\')',
      #        @activity.coworking_space.tables, DateTime.now )
      #
      #      current_tables = current_tables.to_a
      #      all_tables = @activity.coworking_space.tables.to_a
      #      tables_to_delete = all_tables - current_tables
      #
      #      activity_tables_to_delete = ActivityTable.where :table_id => tables_to_delete
      #      #p "activity Tables to delete"
      #      #p activity_tables_to_delete.inspect
      #
      #      separated_reservations = nil
      #      separated_reservations =  Reservation.where :user_id => @activity.coworking_space.user, :table_id => @activity.coworking_space.tables
      #
      #      #p "Cupos reservados"
      #      #p separated_reservations.inspect
      #      tables_to_delete.each do |table|
      #        table.destroy
      #      end
      #
      #      activity_tables_to_delete.each do |table|
      #        table.destroy
      #      end
      #      #
      #      num_to_create = (@tickets[:total]).to_i - current_tables.length
      #      count_separados = separated_reservations.tables.count
      #
      #      if count_separados >= @tickets[:num_separados].to_i
      #        num_to_create.to_i.times { |i|
      #          @cws = @activity.coworking_space
      #          @table = nil
      #
      #          if count_separados < @tickets[:num_separados].to_i
      #            @table = Table.create :coworking_space => @cws, :booked => true, :name => @activity.name+" - cupo No: "+(i+1).to_s, :tipo => 'ticket'
      #            reservation = Reservation.create :table => @table,
      #            :user => @cws.user, :start_time => @activity.start_date,
      #            :state => State.find(3), :duration => @activity.duration
      #          else
      #            @table = Table.create :coworking_space => @cws, :booked => false, :name => @activity.name+" - cupo No: "+(i+1).to_s, :tipo => 'ticket'
      #          end
      #          ActivityTable.create :activity => @activity, :table => @table
      #          count_separados = count_separados + 1
      #        }
      #      else
      #        notice = "Se ha indicado un numero menor de cupos separados al que se ha creado anteriormente, revise los parametros de la actualizacion"
      #        redirect_to @activity, :notice  => notice
      #      end

      redirect_to @activity, :notice  => "Actividad actualizada satisfactoriamente"
      
    else
      render :action => 'edit'
    end
  end

  def destroy
    @activity = Activity.find(params[:id])
    @activity.reservations.each do |r|
      r.destroy
      ReservationsActivity.where(:activity_id => @activity, :reservation_id => r).first.destroy
    end

    @activity.destroy
    redirect_to activities_url, :notice => "Successfully destroyed activity."
  end

  def list
    @cws = CoworkingSpace.find(params[:coworking_space_id])
    @activities = Activity.where :table_id => @cws.tables
    events = []

    @activities.each do |act|
      act.reservations.each do |reservation|
        temp = {:id => reservation.id,
          :name => act.name,
          :title => act.name,
          :start => reservation.start_time,
          :end => reservation.end_time,
          :url => "/activities/"+act.id.to_s
        }
        #p temp.inspect
        events << temp
      end
    end
    respond_to do |format|
      format.html { }
      format.xml { render :xml => events }
      format.json { render :json => events }
    end
  end

  def booking

    @activity = Activity.find(params[:id])
    @tables = @activity.tables.paginate(:page => params[:page]).order('created_at DESC')

    respond_to do |format|
      format.html { }
      format.xml { render :xml => @tables }
      format.json { render :json => @tables }
    end

  end

  def query
    
    limit = params[:limit]
    price = params[:precio]
    category_id = params[:category_id]
    list = []

    price = "" unless price
    category_id = "" unless category_id
    
    list = activities_all_prices(limit, price, category_id)

    respond_to do |format|
      format.html {
        render :layout => false
      }
      format.xml { render :xml => list }
      format.json { render :json => list }
    end


  end

end
