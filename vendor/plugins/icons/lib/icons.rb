# Icons module.
module Icons
  # Icons root path
  IMG_SRC = "/images/icons/"

  # Current icon set
  @@current_set = :silk

  # Icon aliases
  @@aliases = {}

  # Icon sets
  @@sets = {}

  mattr_accessor :current_set
  mattr_accessor :sets
  mattr_accessor :aliases

  # Registers new set  
  def Icons.register_set(id, options)
    @@sets[id] = options
  end

  # Registers new icon alias
  def Icons.alias(aliases)
    @@aliases = @@aliases.merge(aliases)
  end
end

# TODO: move to init.rb?
Icons.register_set(:silk, { :width => 16, :height => 16 });
Icons.register_set(:fugue, { :width => 16, :height => 16 });