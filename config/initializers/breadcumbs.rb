Breadcrumb.configure do
  crumb :root, '#{t("app.products.index")}', :products_url
  crumb :product_dashboard, '#{@product.name}', :product_url, :product
  crumb :product_backlog, '#{t("app.stories.index")}', :product_stories_url, :product

  trail :products, [:index, :new, :edit], [:root]
  trail :stories, :index, [:root, :product_dashboard]
  trail :stories, [:new, :edit], [:root, :product_dashboard, :product_backlog]

  delimit_with " &raquo; "
end

