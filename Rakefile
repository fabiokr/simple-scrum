# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'tasks/rails'

namespace :db do
  desc 'Provide a base load of randomly generated (but valid) data for development'
  task :seed => [:reset, 'fixtures:load'] do

    #generate products
    products = []
    25.times { products << Factory(:product)}

    #generate stories
    stories = []
    200.times { stories << Factory(:story, :product => products.rand)}

    # results
    puts "#{products.size} products created"
    puts "#{stories.size} stories created"
  end
end

