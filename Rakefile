# Rakefile
require "./app/main"
# require "sinatra/activerecord/rake"

require 'cucumber'
require 'cucumber/rake/task'

if RUBY_PLATFORM['java']
  require 'warbler'
  Warbler::Task.new
  begin
    require 'torquebox-rake-support'
  rescue LoadError => ex
    puts "Failed to load the TorqueBox rake gem (torquebox-rake-support). Make sure it is available in your environment."
  end
end

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format pretty -x"
  t.fork = false
end

require 'coffee-script'

namespace :js do
  desc "compile coffee-scripts from ./public/coffeescripts to ./public/javascripts"
  task :compile do
    coffeescripts = "#{File.dirname(__FILE__)}/public/coffeescripts/"
    javascripts = "#{File.dirname(__FILE__)}/public/javascripts/"

    Dir.foreach(coffeescripts) do |cf|
      unless cf == '.' || cf == '..'
        js = CoffeeScript.compile File.read("#{source}#{cf}")
        open "#{javascripts}#{cf.gsub('.coffee', '.js')}", 'w' do |f|
          f.puts js
        end
      end
    end
  end
end