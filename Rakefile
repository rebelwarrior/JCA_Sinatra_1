# Rakefile
require "./app/main"
# require "sinatra/activerecord/rake"

require 'cucumber'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format pretty -x"
  t.fork = false
end