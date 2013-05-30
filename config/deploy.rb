#========================
#CONFIG
#========================

#We're using RVM on the server:
# $:.unshift(File.expand_path('./lib', ENV['rvm_path']))
# require 'rvm/capistrano'
# set :rvm_ruby_string, '1.9.3'
# set :rvm_type, :user
# now use gem 'rvm-capistrano'
set :default_environment, {
      'PATH' => "/home/webmaster/.rvm/rubies/ruby-1.9.3-p429/bin/ruby:$PATH"
    }

set :application, "JCA_Sinatra_1"

#We're using puma
# require 'puma/capistrano'
# require 'bundler/capistrano'
require 'capistrano-puma'
 
set :scm, :git
set :git_enable_submodules, 1
default_run_options[:pty] = true  # Must be set for the password prompt
                                  # from git to work
# set :repository, "git://github.com/rebelwarrior/JCA_Sinatra_1.git"  # Your clone URL
# set :repository, "file://Users/davidacevedo/Code/JCA_1/JCA_Sinatra/"  # Your clone URL
# set :local_repository, "file://."
set :branch, "master"
set :ssh_options, { :forward_agent => true }
 
set :stage, :production
set :user, "webmaster"
set :use_sudo, false
set :runner, "webmaster"
set :deploy_to, "/data/apps/#{stage}/#{application}"
set :app_server, :passenger
set :domain, "198.61.202.168"
 
#========================
#ROLES
#========================
role :app, domain
role :web, domain
role :db, domain, :primary => true

#========================
#CUSTOM
#========================
 
namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
 
  task :stop, :roles => :app do
    # Do nothing.
  end
 
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
end