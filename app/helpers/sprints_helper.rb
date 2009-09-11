module SprintsHelper

  def group_tasks_by_story(sprint)
    stories = {}
    sprint.tasks.each do |task|
      stories[task.story] = [] if stories[task.story].nil?
      stories[task.story] << task
    end
    stories
  end

  def print_task(task, expected_status)
    html = ''
    if task.status == expected_status
      task_html = ''
      task_html << to_previous_state(task)
      task_html << content_tag('div', task.name, :class => 'name')
      task_html << content_tag('div', "#{show_link(product_sprint_taskk_path(@product, @sprint, task))}#{edit_link(edit_product_sprint_taskk_path(@product, @sprint, task))}#{delete_link(product_sprint_taskk_path(@product, @sprint, task))}", :class => 'links')
      task_html << to_next_state(task)
      html << postit(task_html)
    end
    html
  end

  def postit(content)
    content_tag 'div', content, :class => 'postit'
  end

  private

  def to_previous_state(task)
    label = t('app.sprints.previous_state')
    icon = "#{Icons::IMG_SRC}#{Icons.current_set}/arrow_left.png"
    return '' if task.status == Taskk::STATUS[0]
    return change_state_form(task, Taskk::STATUS[0], label, icon) if task.status == Taskk::STATUS[1]
    return change_state_form(task, Taskk::STATUS[1], label, icon) if task.status == Taskk::STATUS[2]
  end

  def to_next_state(task)
    label = t('app.sprints.next_state')
    icon = "#{Icons::IMG_SRC}#{Icons.current_set}/arrow_right.png"
    return change_state_form(task, Taskk::STATUS[1], label, icon) if task.status == Taskk::STATUS[0]
    return change_state_form(task, Taskk::STATUS[2], label, icon) if task.status == Taskk::STATUS[1]
    return '' if task.status == Taskk::STATUS[2]
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

