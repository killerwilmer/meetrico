module TicketsHelper
  def process_it(ticket, step, next_step)
    
    case step      
    when 1 # solicitada
      if next_step.to_i == 2
        Notification.ticket(ticket).deliver
      end
    when 2
      if next_step.to_i == 3
      end
    end
      
  end
end
