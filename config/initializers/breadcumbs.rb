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

  #Trails

  root = [:product_index]

  context 'products controller' do
    trail :products, :index, root
    trail :products, :show, root + [:product_show]
    trail :products, :new,  root + [:product_new]
    trail :products, :edit, root + [:product_edit]
  end

  context 'stories controller' do
    backlog = root + [:product_show, :story_index]

    trail :stories, :index, backlog
    trail :stories, :show,  backlog + [:story_show]
    trail :stories, :new,   backlog + [:story_new]
    trail :stories, :edit,  backlog + [:story_edit]
  end

  delimit_with " &raquo; "
  dont_link_last_crumb
end

