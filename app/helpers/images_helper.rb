module ImagesHelper
  
  def lightbox_image_tag(source, thumb, options = {})
    options[:class] = 'img_container'
    link_to image_tag(thumb, options), source, :rel => 'lightbox'
  end
  
end
