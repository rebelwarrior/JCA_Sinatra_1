#Gemfile
source 'https://rubygems.org'
# ruby '1.9.3', engine: 'jruby', engine_version: '1.7.4'
ruby "2.0.0"
gem 'rack', '~> 1.5'
gem 'sinatra' 
gem 'kramdown' # for markdown
gem 'haml'
gem 'i18n'
gem 'rack-contrib' #for Rack::Locale, etc.
gem 'bundler'
gem 'fastimage', :require => false #for getting image sizes

# For Models:
# gem 'sqlite3' #gem 'pg'
# gem 'activerecord'
# gem 'sinatra-activerecord'

#Optional Stuff not implemented yet
# gem 'sinatra-simple-navigation', require: false #for breadcrumbs
# gem 'gon-sinatra', :require => false #for gon (moves @variables to javascrip)
# gem 'therubyracer' #for coffee-script

group :development do
  gem 'capistrano-puma', require: false
  gem 'rvm-capistrano'
  gem 'pry'
  gem 'shotgun'
  gem 'puma', '~> 2.0'
  gem 'localeapp', require: false 
end

group :production do
  gem 'puma', '~> 2.0'
end

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'rack', '~> 1.5'
  gem 'rack-test'
end

group :development, :test do
  gem 'cucumber'
  gem 'cucumber-sinatra'
  gem 'selenium-webdriver'
end