require 'capistrano/setup'

require 'capistrano/deploy'

task :use_rvm do
  require 'capistrano/rvm'
end

task 'staging'       => [:use_rvm]
task 'demo'          => [:use_rvm]
task 'production'    => [:use_rvm]

require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
