set :deploy_to, '/home/deploy/www/stage.pickofficial.jp'
set :rails_env, "production"
set :stage, :production
set :branch, :master
server '172.104.106.126', user: 'deploy', roles: %w{web}
# set :rvm_custom_path, '/home/deployer/.rvm'
