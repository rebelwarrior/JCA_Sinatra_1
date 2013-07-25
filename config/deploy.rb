set :application, "JCA_portal"
set :repository,  "git@github.com:rebelwarrior/JCA_Sinatra_1.git"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "default"                          # Your HTTP server, Apache/etc
role :app, "default"                          # This may be the same as your `Web` server
# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

# set :user, "deploy"
# Deploy to /home/apps
set :deploy_to, "/home/apps/#{application}"

#setting the server to local host for vagrant box
set :user, "vagrant"
set :port, 2222
# server "10.3.50.89", :app, :web, :db, :primary => true
server "10.0.2.15", :app, :web, :db, :primary => true
set :ssh_options, {:forward_agent => true, keys:
  ['~/.vagrant.d/insecure_private_key'] }
set :default_run_optins, {:pty => true}  
set :stages, ["vagrant"]
set :default_stage, "vagrant"

# For rbenv
default_run_options[:shell] = '/bin/bash --login'
# Run bundler with --binstubs
require 'bundler/capistrano'
set :bundle_flags, "--deployment --binstubs"
set :bundle_without, [:test, :development, :deploy]

# Restart app with runit sv
namespace :deploy do
  task :start do
    run "sudo sv up app2"
  end
  task :stop do
    run "sudo sv down app2"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "sudo sv restart app2"
  end
end