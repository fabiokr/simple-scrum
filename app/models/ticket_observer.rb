class TicketObserver < ActiveRecord::Observer

  def after_save(ticket)
    if ticket.sprint
      calculate_sprint_estimated_velocity(ticket.sprint)
    end
  end

  def after_destroy(ticket)
    if ticket.sprint
      calculate_sprint_estimated_velocity(ticket.sprint)
    end
  end

  private

  def calculate_sprint_estimated_velocity(sprint)
    sprint.estimated_velocity = Ticket.sum('estimative', :conditions => {:sprint_id => sprint.id})
    sprint.save
  end

end

