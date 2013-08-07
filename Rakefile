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