class ContactMessagesController < ApplicationController

  def create
    @contact_message = ContactMessage.new(params[:contact_message])
    if @contact_message.valid?
      Notification.contact_message_email(@contact_message, t(:contact_email)).deliver
      Notification.automatic_promo_response_email(@contact_message).deliver
      flash[:notice] = t(:contact_message_sent)
      redirect_to @contact_message.url
    else
      flash[:notice] = t(:contact_message_has_errors)
      redirect_to root_url
    end

  end

end
