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

end

