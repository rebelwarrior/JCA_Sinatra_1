#config/deploy.rb
#We're using RVM on the server:
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'rvm/capistrano'
set :rvm_ruby_string, '1.9.3'
set :rvm_type, :user


require 'puma/capistrano'
require 'bundler/capistrano'

set :application, "JCA_Sinatra_1"
# set :repository,  "set your repository location here"

default_run_options[:pty] = true  # Must be set for the password prompt
                                  # from git to work
set :repository, "git://github.com/rebelwarrior/JCA_Sinatra_1.git"  # Your clone URL
set :scm, "git"
set :user, "deployer"  # The server's user for deploys
set :scm_passphrase, "p@ssw0rd"  # The deploy user's password


# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "your web-server here"                          # Your HTTP server, Apache/etc
role :app, "your app-server here"                          # This may be the same as your `Web` server
role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
role :db,  "your slave db-server here"

set :branch, "master"
# set :deploy_via, :remote_cache # I want the full clone most times.

set :rails_env, :production



# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

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

#info on how to set this up from http://tech.tulentsev.com/2012/03/deploying-with-sinatra-capistrano-unicorn/
# and git hub page on capistrano