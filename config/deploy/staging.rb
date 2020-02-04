set :deploy_to, '/home/deploy/www/stage.pickofficial.jp'
set :rails_env, "staging"
set :stage, :staging
set :branch, :develop
server '172.104.106.126', user: 'deploy', roles: %w{web}
# set :rvm_custom_path, '/home/deployer/.rvm'
