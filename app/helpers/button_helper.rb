module ButtonHelper
  
  BUTTON_CLASS = 'button'
  BUTTON_CLEAN_CLASS = 'button_clean'
  
  def button_tag(name, icon = nil, html_options = {})
    content_tag('button', "#{icon(icon) if !icon.nil?}#{name if !name.nil?}", html_options)
  end
  
end
