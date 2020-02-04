# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "pickofficial"
set :repo_url, "git@github.com:GIVIN-pick/pickofficial.git"

set :rvm_type, :system
set :rvm_ruby_version, 'ruby-2.5.1 '

set :rails_env, "staging"

set :bundle_flags, '--deployment'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :airbrussh.
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :info

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml',
                                                 'config/master.key',
                                                 '.env')
# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log',
                                               'tmp/pids',
                                               'tmp/cache',
                                               'tmp/sockets',
                                               'public/system',
                                               'public/assets',
                                               'public/uploads')

# Defaults to :db role
set :migration_role, :web

# Defaults to the primary :db server
set :migration_servers, -> { primary(fetch(:migration_role)) }

# Defaults to false
# Skip migration if files in db/migrate were not modified
set :conditionally_migrate, true


# Default value for keep_releases is 5
set :keep_releases, 3

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:web), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  desc 'Runs rake db:migrate if migrations are set'
  task :migrate => [:set_rails_env] do
    on primary fetch(:migration_role) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:migrate"
        end
      end
    end
  end

  after :deploy, 'deploy:restart'
  after :deploy, 'deploy:migrate'

end


