require File.dirname(__FILE__) + '/../../../config/boot'

# Install hook code here
directory = File.join(RAILS_ROOT, '/vendor/plugins/icons/')
#require "#{directory}lib/icons"

def xcopy(options)
  source = options[:source]
  dest = options[:dest]
  logging = options[:logging].nil? ? true : options[:logging]

  Dir.foreach(source) do |entry|
    next if entry =~ /^\./
    if File.directory?(File.join(source, entry))
      unless File.exist?(File.join(dest, entry))
        if logging
          puts "Creating directory #{entry}..."
        end
        FileUtils.mkdir File.join(dest, entry)#, :noop => true#, :verbose => true
      end
      xcopy(:source => File.join(source, entry),
                     :dest => File.join(dest, entry),
                     :logging => logging)
    else
      if logging
        puts "  Installing file #{entry}..."
      end
      FileUtils.cp File.join(source, entry), File.join(dest, entry)#, :noop => true#, :verbose => true
    end
  end
end


puts "** Installing Icons Plugin...."

src = File.join(RAILS_ROOT, '/vendor/plugins/icons/public/images/icons')
dst = File.join(RAILS_ROOT, '/public/images/icons')
unless File.exists?(dst)
  puts "Creating destantion directory..."
  FileUtils.mkdir(dst)
end
xcopy(:source => src, :dest => dst, :logging => true)

puts "** Successfully installed Icons Plugin..."
