module SprintsHelper

  def postit(ticket)
    content_tag('div', "(#{ticket.estimative}) #{truncate ticket.name} #{(ticket.unplanned? && icon(:exclamation, :alt => t('activerecord.attributes.ticket.unplanned'), :title => t('activerecord.attributes.ticket.unplanned'))) || ''}", :class => "postit #{Ticket::CATEGORY_STR[ticket.category_id]}-card")
  end

end

