module Icons
  module Helper#:nodoc:
    # Display an icon.
    #    
    # Options:
    #   +icon+ - icon name (may be symbol), icon alias (symbol), or array of icon name and icon set.
    def icon(icon, options = {}, open = false, escape = true)  
      if Icons.aliases.has_key? icon
        icon = Icons.aliases[icon]
      end

      if icon.kind_of? Array
        set_id = icon[1]
        name = icon[0]
      else
        set_id = Icons.current_set
        name = icon
      end

      set_args = set_id ? Icons.sets[set_id] : Icons.sets[Icons.current_set]

      options = {
        :src => "#{Icons::IMG_SRC}#{set_id}/#{name}.png",
        :border => 0,
        :width => set_args[:width],
        :height => set_args[:height]
      }.merge(options)
      
      tag :img, options, open, escape
    end  
  end
end
