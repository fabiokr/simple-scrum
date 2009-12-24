Breadcrumb.configure do

  #Crumbs
  crumb :user_index, '#{t("app.users.index")}', :users_url
  crumb :user_show, '#{@user.login}', :user_url, '@user'
  crumb :user_new, '#{t("app.users.new")}', :new_user_url
  crumb :user_edit, '#{t("app.users.edit")}', :user_url, '@user'

  crumb :product_index, '#{t("app.products.index")}', :products_url
  crumb :product_show, '#{@product.name}', :product_url, '@product.slug'
  crumb :product_new, '#{t("app.products.new")}', :new_product_url
  crumb :product_edit, '#{t("app.products.edit")}', :product_url, '@product'

  crumb :ticket_index, '#{t("app.tickets.index")}', :product_tickets_url, '@product.slug'
  crumb :ticket_show, '#{t("app.tickets.show")}', :product_ticket_url, '@product.slug', '@ticket.id'
  crumb :ticket_new, '#{t("app.tickets.new")}', :new_product_ticket_url, '@product.slug'
  crumb :ticket_edit, '#{t("app.tickets.edit")}', :edit_product_ticket_url, '@product.slug', '@ticket.id'

  crumb :sprint_index, '#{t("app.sprints.index")}', :product_sprints_url, '@product.slug'
  crumb :sprint_show, '#{@sprint.name}', :product_sprint_url, '@product.slug', '@sprint.id'
  crumb :sprint_new, '#{t("app.sprints.new")}', :new_product_sprint_url, '@product.slug'
  crumb :sprint_edit, '#{t("app.sprints.edit")}', :edit_product_sprint_url, '@product.slug', '@sprint.id'

  crumb :search_show, '#{t("system.search_legend")}', :search_url
  crumb :search_back, '#{t("app.searches.back")}', :back_url

  crumb :settings_edit, '#{t("app.settings.edit")}', :edit_settings_url

  #Trails

  root = [:product_index]

  context 'products controller' do
    trail :products, :index, root
    trail :products, :show, root + [:product_show]
    trail :products, :new,  root + [:product_new]
    trail :products, :create,  root + [:product_new]
    trail :products, :edit, root + [:product_edit]
    trail :products, :update, root + [:product_edit]
  end

  context 'tickets controller' do
    controller_root = root + [:product_show, :ticket_index]

    trail :tickets, :index, controller_root
    trail :tickets, :show,  controller_root + [:ticket_show]
    trail :tickets, :new,   controller_root + [:ticket_new]
    trail :tickets, :create,   controller_root + [:ticket_new]
    trail :tickets, :edit,  controller_root + [:ticket_edit]
    trail :tickets, :update,  controller_root + [:ticket_edit]
  end

  context 'sprints controller' do
    controller_root = root + [:product_show, :sprint_index]

    trail :sprints, :index, controller_root
    trail :sprints, :show,  controller_root + [:sprint_show]
    trail :sprints, :new,   controller_root + [:sprint_new]
    trail :sprints, :create,   controller_root + [:sprint_new]
    trail :sprints, :edit,  controller_root + [:sprint_edit]
    trail :sprints, :update,  controller_root + [:sprint_edit]
  end

  context 'users controller' do
    controller_root = [:user_index]

    trail :users, :index, controller_root
    trail :users, :show, controller_root + [:user_show]
    trail :users, :new,  controller_root + [:user_new]
    trail :users, :create,  controller_root + [:user_new]
    trail :users, :edit, controller_root + [:user_edit]
    trail :users, :update, controller_root + [:user_edit]
  end

  context 'searches controller' do
    trail :searches, :show, [:search_show, :search_back]
  end

  context 'settings controller' do
    trail :settings, :edit, [:settings_edit]
  end

  delimit_with "|"
  dont_link_last_crumb
end

