# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def title()
    controller = @controller.controller_name
    action = @controller.action_name
    title = "#{I18n.t('app.name')} &raquo; #{I18n.t("app.#{controller}.index")}"
    title <<  " &raquo; #{I18n.t("app.#{controller}.#{action}")}" if action != 'index'
    title
  end

  #returns the :class value form form_errors
  def form_errors_class
    {:class => 'error'}
  end

  #Adds a : to the label
  def show_label(t)
    t(t) + ':'
  end

  def new_link(path, text)
    link_to "#{icon(:page_add, :alt => text)}#{text}", path, :class => 'button newLink inline'
  end

  def show_link(path)
    link_to icon(:page, :alt => t('system.show')), path, :title => t('system.show'), :class => 'showLink'
  end

  def edit_link(path)
    link_to icon(:page_edit, :alt => t('system.edit')), path, :title => t('system.edit'), :class => 'editLink'
  end

  def delete_link(path)
    html_options = html_options_for_form(path,{})

    form = content_tag('form', :action => html_options['action'], :method => 'post', :class => 'deleteLink inline') do
      content = ''
      content << hidden_field_tag('_method', 'delete', :id => nil)
      content << hidden_field_tag(request_forgery_protection_token.to_s, form_authenticity_token, :id => nil)
      content << image_submit_tag("#{Icons::IMG_SRC}#{Icons.current_set}/page_delete.png", :alt => t('system.destroy'), :title => t('system.destroy'))
    end
  end

  def button_tag(name, icon = nil, html_options = {})
    content_tag('button', "#{icon(icon) if !icon.nil?}#{name if !name.nil?}", html_options)
  end

  #Specific breadcumbs helper implementation to add ul and li
  def breadcrumbs
    home = link_to(image_tag('home.png', :class => 'home'), '/', :title => t('app.home'))
    breadcrumbs = [home] + crumbs.split(Breadcrumb.instance.delimiter)
    content_tag(:ul, breadcrumbs.map { |trail| content_tag(:li, trail) }, :id => 'breadcrumb')
  end

end

