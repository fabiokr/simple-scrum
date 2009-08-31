Breadcrumb.configure do

  #Crumbs
  crumb :product_index, '#{t("app.products.index")}', :products_url
  crumb :product_show, '#{@product.name}', :product_url, :product
  crumb :product_new, '#{t("app.products.new")}', :new_product_url
  crumb :product_edit, '#{t("app.products.edit")}', :product_url, :product

  crumb :story_index, '#{t("app.stories.index")}', :product_stories_url, :product
  crumb :story_show, '#{t("app.stories.show")}', :product_story_url, :product, :story
  crumb :story_new, '#{t("app.stories.new")}', :new_product_story_url, :product
  crumb :story_edit, '#{t("app.stories.edit")}', :edit_product_story_url, :product, :story

  crumb :sprint_index, '#{t("app.sprints.index")}', :product_sprints_url, :product
  crumb :sprint_show, '#{t("app.sprints.show")}', :product_sprint_url, :product, :sprint
  crumb :sprint_new, '#{t("app.sprints.new")}', :new_product_sprint_url, :product
  crumb :sprint_edit, '#{t("app.sprints.edit")}', :edit_product_sprint_url, :product, :sprint

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

  delimit_with "|"
  dont_link_last_crumb
end

