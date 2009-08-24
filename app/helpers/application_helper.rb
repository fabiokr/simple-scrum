# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  #returns the :class value form form_errors
  def form_errors_class
    {:class => 'error'}
  end

  #Adds a : to the label
  def show_label(t)
    t(t) + ':'
  end

  def new_link(path, text)
    link_to "#{icon(:page_add, :alt => text)}#{text}", path, :class => 'button newLink'
  end

  def show_link(path)
    link_to icon(:page, :alt => t('system.show')), path, :title => t('system.show'), :class => 'showLink'
  end

  def edit_link(path)
    link_to icon(:page_edit, :alt => t('system.edit')), path, :title => t('system.edit'), :class => 'editLink'
  end

  def delete_link(path)
    html_options = html_options_for_form(path,{})

    form = content_tag('form', :action => html_options['action'], :method => 'post', :class => 'deleteLink') do
      content = ''
      content << hidden_field_tag('_method', 'delete', :id => nil)
      content << hidden_field_tag(request_forgery_protection_token.to_s, form_authenticity_token, :id => nil)
      content << image_submit_tag("#{Icons::IMG_SRC}#{Icons.current_set}/page_delete.png", :alt => t('system.destroy'), :title => t('system.destroy'))
    end
  end

end

