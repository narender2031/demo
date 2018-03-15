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

# namespace :rails do
#   desc 'Open a rails console `cap [staging] rails:console [server_index default: 0]`'
#   task :console do    
#     server = roles(:app)[ARGV[2].to_i]

#     puts "Opening a console on: #{server.hostname}...."

#     cmd = "ssh #{fetch(:user)}@#{server.hostname} -t 'cd #{fetch(:deploy_to)}/current && RAILS_ENV=#{fetch(:rails_env)} bundle exec rails console'"

#     puts cmd

#     exec cmd
#   end
# end
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
