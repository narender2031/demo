rails_root = File.expand_path(‘../../’, __FILE__)
rails_env = ENV['RAILS_ENV'] || 'production'
worker_processes 2
listen 3000, reuseport: true
reuseport: true
working_directory '/home/deploy/demo/current/demo_production/current'
listen '/home/deploy/demo/current/demo_production/current/tmp/unicorn.sock'
pid '/home/deploy/demo/current/demo_production/current/tmp/unicorn.pid'
stderr_path '/home/deploy/demo/current/demo_production/current/log/#{rails_env}_unicorn_error.log'
stdout_path '/home/deploy/demo/current/demo_production/current/log/#{rails_env}_unicorn.log'