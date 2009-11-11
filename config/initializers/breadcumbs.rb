Breadcrumb.configure do

  #Crumbs
  crumb :user_index, '#{t("app.users.index")}', :users_url
  crumb :user_show, '#{@user.login}', :user_url, :user
  crumb :user_new, '#{t("app.users.new")}', :new_user_url
  crumb :user_edit, '#{t("app.users.edit")}', :user_url, :user

  crumb :product_index, '#{t("app.products.index")}', :products_url
  crumb :product_show, '#{@product.name}', :product_url, :product
  crumb :product_new, '#{t("app.products.new")}', :new_product_url
  crumb :product_edit, '#{t("app.products.edit")}', :product_url, :product

  crumb :story_index, '#{t("app.stories.index")}', :product_stories_url, :product
  crumb :story_show, '#{t("app.stories.show")}', :product_story_url, :product, :story
  crumb :story_new, '#{t("app.stories.new")}', :new_product_story_url, :product
  crumb :story_edit, '#{t("app.stories.edit")}', :edit_product_story_url, :product, :story

  crumb :sprint_index, '#{t("app.sprints.index")}', :product_sprints_url, :product
  crumb :sprint_show, '#{@sprint.name}', :product_sprint_url, :product, :sprint
  crumb :sprint_new, '#{t("app.sprints.new")}', :new_product_sprint_url, :product
  crumb :sprint_edit, '#{t("app.sprints.edit")}', :edit_product_sprint_url, :product, :sprint

  crumb :task_show, '#{t("app.taskks.show")}', :product_sprint_taskk_url, :product, :sprint, :task
  crumb :task_new, '#{t("app.taskks.new")}', :new_product_sprint_taskk_url, :product, :sprint
  crumb :task_edit, '#{t("app.taskks.edit")}', :edit_product_sprint_taskk_url, :product, :sprint, :task

  crumb :search_show, '#{t("app.searches.result")}', :search_url

  crumb :settings_edit, '#{t("app.settings.edit")}', :edit_settings_url

  #Trails

  root = [:product_index]

  context 'products controller' do
    trail :products, :index, root
    trail :products, :show, root + [:product_show]
    trail :products, :new,  root + [:product_new]
    trail :products, :edit, root + [:product_edit]
  end

  context 'stories controller' do
    controller_root = root + [:product_show, :story_index]

    trail :stories, :index, controller_root
    trail :stories, :show,  controller_root + [:story_show]
    trail :stories, :new,   controller_root + [:story_new]
    trail :stories, :edit,  controller_root + [:story_edit]
  end

  context 'sprints controller' do
    controller_root = root + [:product_show, :sprint_index]

    trail :sprints, :index, controller_root
    trail :sprints, :show,  controller_root + [:sprint_show]
    trail :sprints, :new,   controller_root + [:sprint_new]
    trail :sprints, :edit,  controller_root + [:sprint_edit]
  end

  context 'taskks controller' do
    controller_root = root + [:product_show, :sprint_index, :sprint_show]

    trail :taskks, :show,  controller_root + [:task_show]
    trail :taskks, :new,   controller_root + [:task_new]
    trail :taskks, :edit,  controller_root + [:task_edit]
  end

  context 'users controller' do
    controller_root = [:user_index]

    trail :users, :index, controller_root
    trail :users, :show, controller_root + [:user_show]
    trail :users, :new,  controller_root + [:user_new]
    trail :users, :edit, controller_root + [:user_edit]
  end

  context 'searches controller' do
    trail :searches, :show, [:search_show]
  end

  context 'settings controller' do
    trail :settings, :edit, [:settings_edit]
  end

  delimit_with "|"
end

