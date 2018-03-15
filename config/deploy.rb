# config valid for current version and patch releases of Capistrano
lock "~> 3.10.1"

set :application, "demo"
set :repo_url, "git@github.com:narender2031/demo.git"
set :user,     'deploy'
# set :rbenv_type, 'deploy'
# set :rbenv_ruby, '2.4.1'
#  set :rbenv_path, '/home/deploy/.rbenv/'
#  set :rbenv_prefix, "/home/deploy/.rbenv/bin/rbenv exec"
# set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa) }
# dirs we want symlinked to the shared folder
# during deployment
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
      #
	  # The capistrano-unicorn-nginx gem handles all this
	  # for this example
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end