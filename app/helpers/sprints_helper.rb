module SprintsHelper

  def group_tasks_by_story(sprint)
    stories = {}
    sprint.tasks.each do |task|
      stories[task.story] = [] if stories[task.story].nil?
      stories[task.story] << task
    end
    stories
  end

end

