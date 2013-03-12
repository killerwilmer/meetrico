class WelcomeController < ApplicationController

  def index
    #@promo_space = CoworkingSpace.hot_promotions
    @promos = ItemCategoryDecorator.decorate(ItemCategory.hot_promotions)
    @contact_message = ContactMessage.new
  end

  def index_new
    @coworking_spaces = CoworkingSpace.all
  end

  def about
  end

  def us
  end

  def lapapaya
  end

  def testimonios
  end

  def prensa
  end

  def faq
  end

  def ciudad_digital
  end

  def became_owner
    @subscription_request = SubscriptionRequest.new
    @subscription_request.user = current_user
    @cities = City.all
    @contact_message = ContactMessage.new
  end

  def contact
  end

  def addtonewsletter

    #@news_letter_emails =
    begin
      NewsLetterEmails.create :email => params[:email_newsletter]
      Notification.addtonewsletter(params[:email_newsletter]).deliver

      flash[:notice] = "Gracias por darte de alta en nuestra base de datos"
    rescue ActiveRecord::RecordNotUnique
      flash[:notice] = "El email: "+params[:email_newsletter]+", ya se encuentra registrada en nuestro sistema."
    end

    redirect_to root_url
  end
  
  def newindex
    render :layout => "webapp"
  end

end
