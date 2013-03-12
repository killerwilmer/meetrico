class ActivityReservationsController < ApplicationController

  include ApplicationHelper
  include ActivitiesHelper

  before_filter :authenticate_owner_or_admin, :only => [:new, :edit, :update, :index, :delete]
  layout :choose_layout_all_profiles

  def index
    @activity = Activity.find(params[:activity_id])
    @reservations = @activity.reservations
  end
end
