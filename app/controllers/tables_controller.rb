class TablesController < InheritedResources::Base
  include ApplicationHelper

  before_filter :authenticate_owner_or_admin, :only => [:new, :edit, :update, :index]
  layout :choose_layout_all_profiles

  def validate_reservation_datetime

    table = Table.find(params[:id])
    init_time = params[:init_time]
    init_date = params[:init_date]
    duration = params[:duration]
    recurrent_type = params[:recurrent_type]
    recurrent = params[:recurrent]
    num_times = params[:num_times]

    to_return = {
      :valid => true,
      :message => "El espacio esta disponible, disfrutalo!",
      :next_available_time => "",
      :valid_dates => [],
      :invalid_dates => []
    }
    
    recurrent_dates_list = []
    reservation_attempt_start_time = Time.parse(init_date+" "+init_time)    
    #reservation_attempt_end_time = reservation_attempt_start_time+(duration.to_i*60*60)

    periodicity = 0

    case recurrent_type
    when "daily"
      periodicity = 1
    when "weekly"
      periodicity = 7
    when "monthly"
      periodicity = 30
    end

    num_times.to_i.times do |t|
      
      loop = periodicity * (t+1)      
      recurrent_dates_list << reservation_attempt_start_time+(loop*24*60*60)
    end

    
    recurrent_dates_list << reservation_attempt_start_time
    
    targets = []

    recurrent_dates_list.each do |r|
      targets << r.to_date
    end
    reservations = table.reservations.select(["start_time", "end_time", "user_id"])
    .active.where(" date(start_time) in (?)", targets)

    recurrent_dates_list.each do |recurrent|
      valid_recurrent = true
      reservation_attempt_start_time = recurrent
      reservation_attempt_end_time = reservation_attempt_start_time+(duration.to_i*60*60)
      reservations.each do |reservation|
        locked = false
        if reservation.start_time != reservation_attempt_start_time
          hour = reservation.start_time
          hour_target = reservation_attempt_start_time
          begin
            begin
              #p hour.strftime("%Y-%m-%d %H:%M:%S").to_s+" = "+hour_target.strftime("%Y-%m-%d %H:%M:%S").to_s
              if hour.strftime("%Y-%m-%d %H:%M:%S").to_s == hour_target.strftime("%Y-%m-%d %H:%M:%S").to_s
                locked = true # blokeado
                valid_recurrent = false
                to_return[:valid] = false
                user = User.find(reservation[:user_id])
                to_return[:message] = "El item: "+table.name.to_s+" esta reservado desde las: "+
                  reservation.start_time.to_s+" hasta las "+
                  reservation.end_time.to_s+" por "+user.name

                to_return[:next_available_time] = (reservation.end_time+3600)  
                to_return[:invalid_dates] << reservation.start_time.strftime("%Y-%m-%d %H:%M:%S")
              end
              
              hour += 1800
            end while hour < reservation.end_time  and not locked
            hour = reservation.start_time
            hour_target += 1800
          end while hour_target < reservation_attempt_end_time  and not locked
        else
          #p "bloqueado"
          to_return[:valid] = false
          to_return[:message] = "El item: "+table.name.to_s+" esta reservado desde las: "+
            reservation.start_time.to_s+" hasta las "+
            reservation.end_time.to_s+" por "+reservation.user.name
          to_return[:next_available_time] = (reservation.end_time+3600)
          to_return[:invalid_dates] << reservation.start_time.strftime("%Y-%m-%d %H:%M:%S")
        end
      
      end

      if valid_recurrent
        to_return[:valid_dates] << recurrent.strftime("%Y-%m-%d %H:%M:%S")
      else
        valid_recurrent = true
      end
    end

    respond_to do |format|
      format.html {
        render :layout => params[:layout] if params[:layout]
      }
      format.xml { render :xml => to_return.to_xml }
      format.json { render :json => to_return.to_json }
    end
  end

  def gallery
    @table = params[:id]
    @images = @table.images if @table.images.size > 0
    
  end

  def index
    @tables = Table.paginate(:page => params[:page]).order('created_at DESC').where(:tipo => 'resource') if admin_signed_in? and not user_signed_in? and not current_user.try(:owner?)
    @tables = Table.paginate(:page => params[:page]).order('created_at DESC').joins(:coworking_space).where(:tipo => 'resource', :coworking_spaces => {:user_id => current_user}) if user_signed_in? and current_user.try(:owner?)
  end

  def delete
  end

  

  def new
    @table = Table.new
    @coworking_spaces = CoworkingSpace.all if admin_signed_in? and not current_user.try(:owner?) and not user_signed_in?
    @coworking_spaces = CoworkingSpace.where :user_id => current_user if current_user.try(:owner?) and user_signed_in? and not admin_signed_in?
  end

  def edit
    @table = Table.find(params[:id])
    @coworking_spaces = CoworkingSpace.all if admin_signed_in? and not current_user.try(:owner?) and not user_signed_in?
    @coworking_spaces = CoworkingSpace.where :user_id => current_user if current_user.try(:owner?) and user_signed_in? and not admin_signed_in?
  end

  #  def destroy
  #    @table = Table.find(params[:id])
  #
  #    if @table.reservations.length <= 0
  #      #@table.destroy
  #      flash[:notice] = "El producto se ha eliminado exitosamente"
  #    else
  #      flash[:notice] = "El producto "+@table.name+", perteneciente al espacio: "+
  #        @table.coworking_space.name+" no se elimina ya que esta relacionado con ("+
  #        @table.coworking_space.length.to_s+") reservas"
  #    end
  #
  #    redirect_to tables_path
  #
  #  end

  def by_item_category
    @coworking_space = CoworkingSpace.find(params[:coworking_space_id])
    @item_category = ItemCategory.find(params[:item_category_id])
    @tables = @coworking_space.tables.where(:item_category_id => @item_category)

    p @tables.inspect
    
    respond_to do |format|
      format.html { render :layout => false }
    end

  end
end
