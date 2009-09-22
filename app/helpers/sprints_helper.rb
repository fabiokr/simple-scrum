module SprintsHelper

  def group_tasks_by_story(sprint)
    stories = {}
    sprint.tasks.each do |task|
      stories[task.story] = [] if stories[task.story].nil?
      stories[task.story] << task
    end
    stories
  end

  def print_story(story)
    html = ''
    html << content_tag('div', "#{story.name} (#{story.estimative})", :class => 'name')
    html << content_tag('div', "#{show_link(product_story_path(@product, story))}#{edit_link(edit_product_story_path(@product, story))}#{delete_link(product_story_path(@product, story))}", :class => 'links')
    postit(html, 'story', story.color)
  end

  def print_task(task, expected_status)
    html = ''
    if task.status == expected_status
      task_html = ''
      task_html << to_previous_state(task)
      task_html << content_tag('div', "#{task.name} (#{task.estimative}) #{(task.unplanned? && icon(:exclamation, :alt => t('activerecord.attributes.taskk.unplanned'), :title => t('activerecord.attributes.taskk.unplanned'))) || ''}", :class => 'name')
      task_html << content_tag('div', "#{show_link(product_sprint_taskk_path(@product, @sprint, task))}#{edit_link(edit_product_sprint_taskk_path(@product, @sprint, task))}#{delete_link(product_sprint_taskk_path(@product, @sprint, task))}", :class => 'links')
      task_html << to_next_state(task)
      html << postit(task_html, 'task', task.story.color)
    end
    html
  end

  private

  def postit(content, html_class = nil, color = nil)
    html_class = "postit #{html_class}"
    style = "background-color:##{color}" unless color.nil?
    content_tag 'div', content, :class => html_class, :style => style
  end

  def to_previous_state(task)
    label = t('app.sprints.previous_state')
    icon = "#{Icons::IMG_SRC}#{Icons.current_set}/arrow_left.png"
    return '' if task.status == Taskk::TODO
    return change_state_form(task, Taskk::TODO, label, icon) if task.status == Taskk::DOING
    return change_state_form(task, Taskk::DOING, label, icon) if task.status == Taskk::DONE
  end

  def to_next_state(task)
    label = t('app.sprints.next_state')
    icon = "#{Icons::IMG_SRC}#{Icons.current_set}/arrow_right.png"
    return change_state_form(task, Taskk::DOING, label, icon) if task.status == Taskk::TODO
    return change_state_form(task, Taskk::DONE, label, icon) if task.status == Taskk::DOING
    return '' if task.status == Taskk::DONE
  end

  def change_state_form(task, status, label, icon)
    html_options = html_options_for_form(product_sprint_taskk_path(task.sprint.product, task.sprint, task),{})
    form = ''
    form = content_tag('form', :action => html_options['action'], :method => 'post', :class => 'changeState') do
      content = ''
      content << hidden_field_tag('_method', 'put', :id => nil)
      content << hidden_field_tag(request_forgery_protection_token.to_s, form_authenticity_token, :id => nil)
      content << hidden_field_tag('taskk[status]', status)
      content << image_submit_tag(icon, :alt => label, :title => label)
    end
    content_tag 'div', form, :class => 'changeState'
  end

end

