#Gemfile
source 'https://rubygems.org'
gem 'rack'
gem 'sinatra' 
gem 'rdiscount' #or other markdown engine
gem 'haml'
gem 'i18n'
gem 'rack-contrib' #for Rack::Locale

# For Models:
# gem 'sqlite3' #gem 'pg'
# gem 'activerecord'
# gem 'sinatra-activerecord'

#Optional Stuff not implemented yet
gem 'sinatra-simple-navigation', require: false #for breadcrumbs
gem 'gon-sinatra', :require => false


group :development do
  gem 'shotgun'
  gem 'thin'
  gem 'localeapp', require: false 
end

group :production do
  gem 'puma'
end

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'rack'
  gem 'rack-test'
end

group :development, :test do
  gem 'cucumber'
  gem 'cucumber-sinatra'
end