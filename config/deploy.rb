require "byebug"

set :use_sudo, false
set :deploy_via, :copy
set :keep_releases, 5
set :pty, true
set :repo_url, 'git@bitbucket.org:parkstation/colorcoin.git'l

set :deploy_to, '/home/deployer/sites/blockstarter'
set :rvm_ruby_version, 'ruby-2.2.3@blockstarter --create'

set :linked_files, %w(config/database.yml config/application.yml)
set :linked_dirs, %w(log tmp public/uploads public/system)


namespace :deploy do
  desc 'Setup production'
  task :setup do
    on roles(:all) do
      invoke 'setup:config'
      # invoke 'setup:backup'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 10 do
      if test("[ -f #{deploy_to}/current/tmp/pids/puma.pid ]")
        within "#{fetch(:deploy_to)}/current/" do
          execute :bundle, :exec, :"pumactl -F config/puma.rb stop"
          execute :bundle, :exec, :"puma -C config/puma.rb -e #{fetch(:stage)}"
        end
      else
        within "#{fetch(:deploy_to)}/current/" do
          execute :bundle, :exec, :"puma -C config/puma.rb -e #{fetch(:stage)}"
        end
      end
    end
  end

  namespace :bower do
    desc 'Install bower'
    task :install do
      on roles(:all) do
	within release_path do
	  execute :rake, 'bower:install CI=true'
	end
      end
    end
  end

  before 'deploy:compile_assets', 'bower:install'

  after :publishing, :restart
end

namespace :setup do
  desc 'Setup application config files'
  task :config do
    on roles(:all) do
      #execute "mkdir -p #{deploy_to}/current"
      execute "mkdir -p #{deploy_to}/shared/config"
      execute "mkdir -p #{deploy_to}/shared/tmp/pids"
      execute "mkdir -p #{deploy_to}/shared/tmp/sockets"
      execute "mkdir -p #{deploy_to}/shared/public/system"
      upload!("config/production/database.production.yml", "#{deploy_to}/shared/config/database.yml")
      upload!("config/production/application.production.yml", "#{deploy_to}/shared/config/application.yml")
      # sudo /etc/init.d/monit start
    end
  end

  desc 'Install gem for backups'
  task :backup do
    on roles(:app) do
      execute "/bin/bash -lc 'gem install backup:4.2.2 --no-ri --no-rdoc'"
    end
  end

end

