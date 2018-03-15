# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server "example.com", user: "deploy", roles: %w{app db web}, my_property: :my_value
# server "example.com", user: "deploy", roles: %w{app web}, other_property: :other_value
# server "db.example.com", user: "deploy", roles: %w{db}



# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{deploy@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com}



# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.



# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# The server-based syntax can be used to override options:
# ------------------------------------
# server "example.com",
#   user: "user_name",
#   roles: %w{web app},
#   ssh_options: {
#     user: "user_name", # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: "please use keys"
#   }
# set :user,  'deploy'
# set :stage,      :production
# set :unicorn_rack_env, 'stage'
# set :rails_env, 'stage'
# set :migration_role, 'db'
# # server '13.126.252.2', roles: [:web, :app, :db], primary: true
# role :app, %w{ec2-13-126-252-2.ap-south-1.compute.amazonaws.com} # Server IP Address
# role :web, %w{ec2-13-126-252-2.ap-south-1.compute.amazonaws.com}
# role :db, %w{ec2-13-126-252-2.ap-south-1.compute.amazonaws.com}
# set :ssh_options,     { forward_agent: true, user: 'deploy', keys: %w(~/.ssh/id_rsa) }
# set :ssh_options, {
# keys: [File.expand_path('~/.ssh/meeting.pem')],
# forward_agent: true,
# user: 'deploy',
# auth_methods: %w(publickey)
# }
# # server '13.126.252.2', roles: [:web, :app, :db], primary: true
# server 'ec2-13-126-252-2.ap-south-1.compute.amazonaws.com', user: 'ubuntu', roles: %w{web app db}

server '', roles: [:web, :app, :db], primary: true
# production deployment
set :stage, :production
# use the master branch of the repository
set :branch, "master"
# the user login on the remote server
# used to connect and deploy
set :deploy_user, "YourAzureVMUserName"
# the 'full name' of the application
set :full_app_name, "#{fetch(:application)}_#{fetch(:stage)}"
# the server(s) to deploy to
server '139.59.80.132', user: 'deploy', roles: %w{web app db}, primary: true
# the path to deploy to
set :deploy_to, "/home/#{fetch(:deploy_user)}/demo/current/#{fetch(:full_app_name)}"
# set to production for Rails
set :rails_env, :production