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
      task_html << content_tag('div', task.name, :class => 'name')
      task_html << content_tag('div', "#{show_link(product_sprint_taskk_path(@product, @sprint, task))}#{edit_link(edit_product_sprint_taskk_path(@product, @sprint, task))}#{delete_link(product_sprint_taskk_path(@product, @sprint, task))}", :class => 'links')
      html << postit(task_html)
    end
    html
  end

  def postit(content)
    content_tag 'div', content, :class => 'postit'
  end

end

