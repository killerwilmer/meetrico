class SubscriptionRequestsController < InheritedResources::Base
  before_filter :authenticate_admin!, :only => [:index, :edit]

  def index
    @subscription_requests = SubscriptionRequest.all
    respond_to do |format|
      format.html {
        render :layout => 'admin'
      }
      format.xml { render :xml => @subscription_requests }
      format.json { render :json => @subscription_requests }
    end
  end

  def edit
    @subscription_request = SubscriptionRequest.where(:id => params[:id]).first
    respond_to do |format|
      format.html {
        render :layout => 'admin'
      }
      format.xml { render :xml => @subscription_request }
      format.json { render :json => @subscription_request }
    end
  end
  
end
