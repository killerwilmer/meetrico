class Notification < ActionMailer::Base
  default :from => "Meetrico <administrador@meetrico.com>"
  default :cc => %w(miguel.diaz@codescrum.com)

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification.reservation.subject
  #
  def reservation(reservation)
    @reservation = reservation

    mail :to => @reservation.user.email
  end

  def ticket(ticket)
    @ticket = ticket
    @reservation = @ticket.reservation
    mail :to => @ticket.user.email
  end

  def paypal_link(reservation, hash)
    @reservation = reservation
    @hash = hash
    
    mail :to => @reservation.user.email
  end

  def reservation_request(reservation)
    @reservation = reservation

    mail :to => @reservation.user.email
  end

  def addtonewsletter(email)
    mail :to => email
  end

  def automatic_promo_response_email(contact_message)
    @contact_message = contact_message
    mail :to => @contact_message.email, subject: t(:automatic_promo_response_email_subject, promo_name: @contact_message.promo_name)
  end

  # TODO: Set a background job manager as delay job or
  def contact_message_email(contact_message, email)
    @contact_message = contact_message
    @contact_meseage_receiver = email
    mail :to => email, subject: t(:contact_message_email_subject, promo_name: @contact_message.promo_name, name: @contact_message.name)
  end

  def pay_ticket(ticket)
    @ticket = ticket
    mail :to => @ticket.user.email
  end
end
