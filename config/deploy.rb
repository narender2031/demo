# config valid for current version and patch releases of Capistrano
lock "~> 3.10.1"

set :application, "demo"
set :repo_url, "git@github.com:narender2031/demo.git"
set :deploy_user, "deploy"
set :user,     'deploy'
set :deploy_to, "/home/#{fetch :deploy_user}/#{fetch :application}"
# set :rbenv_type, 'deploy'
# set :rbenv_ruby, '2.4.1'
#  set :rbenv_path, '/home/deploy/.rbenv/'
#  set :rbenv_prefix, "/home/deploy/.rbenv/bin/rbenv exec"
# set :rbenv_map_bins, %w{rake gem bundle ruby rails}
# append :linked_dirs, "config/database.yml", "config/secrets.yml"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa) }
# dirs we want symlinked to the shared folder
# during deployment
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :deploy do
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "if [ -f #{unicorn_pid} ]; then kill -s USR2 `cat #{unicorn_pid}`; fi"
  end

  task :force_restart, :roles => :app, :except => { :no_release => true } do
    stop
    start
  end

  task :stop, :roles => :app, :except => { :no_release => true } do
    run "if [ -f #{unicorn_pid} ]; then kill -s QUIT `cat #{unicorn_pid}`; fi"
  end

  task :start, :roles => :app do
    run "cd #{current_path} && #{unicorn_binary}"
  end

  task :symlink_database, :roles => :app do
    run "cd #{current_path}/config && ln -s #{current_path}/../../shared/config/database.yml ."
  end
end