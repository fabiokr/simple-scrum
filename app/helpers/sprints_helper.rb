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
      task_html << task.name
      task_html << show_link(product_sprint_taskk_path(@product, @sprint, task))
      task_html << edit_link(edit_product_sprint_taskk_path(@product, @sprint, task))
      task_html << delete_link(product_sprint_taskk_path(@product, @sprint, task))
      html << postit(task_html)
    end
    html
  end

  def postit(content)
    content_tag 'div', content, :class => 'postit'
  end

end

