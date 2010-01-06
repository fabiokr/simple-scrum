module SprintsHelper

  def postit(ticket)
    content_tag('div', "(#{ticket.estimative}) #{truncate ticket.name} #{(ticket.unplanned? && icon(:exclamation, :alt => t('activerecord.attributes.ticket.unplanned'), :title => t('activerecord.attributes.ticket.unplanned'))) || ''}", :ticket_status => ticket.status, :ticket_show_url => product_ticket_path(ticket.product.slug, ticket), :class => "postit #{Ticket::CATEGORY_STR[ticket.category_id]}-card")
  end

  def burndown_chart(sprint)
    plot = sprint.burndown_plot

    return t('app.sprints.burndown_chart_not_enought') if plot[:expected][:x].empty? || plot[:expected][:y].empty? || plot[:current][:x].empty? || plot[:current][:y].empty?

    image_tag(
      Gchart.line_xy(
        :size => '750x400',
        :legend => [t('app.sprints.burndown_chart_expected_line'), t('app.sprints.burndown_chart_current_line')],
        :axis_with_labels => ['x', 'y'],
        :bar_colors => ['FF0000','00FF00'],
        :custom => 'chls=3,6,3|3,6,0&chg=10,10,1,5',
        :data => [plot[:expected][:x], plot[:expected][:y], plot[:current][:x], plot[:current][:y]],
        :axis_labels => [plot[:labels][:x], plot[:labels][:y]]
      ),
      :alt => t('app.sprints.burndown_chart')
    )
  end

end

