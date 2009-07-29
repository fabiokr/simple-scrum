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

  def show_link(path)
    link_to icon(:page), path, :alt => t('system.show'), :title => t('system.show'), :class => 'showLink'
  end

  def edit_link(path)
    link_to icon(:page_edit), path, :alt => t('system.edit'), :title => t('system.edit'), :class => 'editLink'
  end

  def delete_link(path)
    link_to icon(:page_delete), path, :confirm => t('system.confirm'), :method => :delete, :alt => t('system.destroy'), :title => t('system.destroy'), :class => 'deleteLink'
  end

end

