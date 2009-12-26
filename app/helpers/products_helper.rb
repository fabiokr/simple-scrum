module ProductsHelper

  def sprint_title(sprint)
    html = ''
    html << sprint.name
    (html << " (#{h sprint.start.to_formatted_s(:short)} - #{h sprint.end.to_formatted_s(:short)})") unless sprint.start.nil? || sprint.end.nil?
    html
  end

end

