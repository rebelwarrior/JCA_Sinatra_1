#Gemfile
source 'https://rubygems.org'
#ruby=jruby-1.7.10
# ruby "2.0.0"
gem 'rack'
gem 'sinatra' 

gem 'kramdown' # for markdown
gem 'haml'

gem 'i18n' #Internationalization
gem 'rack-contrib' #for Rack::Locale, etc.
gem 'bundler'

#CoffeeScript & Javascript Engine
gem 'coffee-script'
gem 'therubyracer', :platforms => :ruby
gem 'therubyrhino', :platforms => :jruby

# For Models:
gem 'sqlite3',                   :platforms => :ruby
gem 'jdbc-sqlite3',              :platforms => :jruby
# gem 'activerecord-jdbc-adapter', :platforms => :jruby
# gem 'activerecord'
# gem 'sinatra-activerecord'

#Server
gem 'puma'

#Optional Stuff not implemented yet
# gem 'sinatra-simple-navigation', require: false #for breadcrumbs
gem 'gon-sinatra', :require => false #for gon (moves @variables to javascript)
# gem 'fastimage', :require => false #for getting image sizes

group :development do
  # gem 'rvm-capistrano', require: false
  gem 'pry',            require: false
  gem 'shotgun',        require: false
  gem 'localeapp',      require: false
end

group :deploy do
  platforms :jruby do
    gem 'warbler', '~> 1.4.0' 
    # gem 'net-ssh', :require => "net/ssh"
    # gem 'net-scp', :require => "net/scp" 
    # gem 'torquebox-remote-deployer'
  end
end

group :production do
end

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'rack-test'
  # gem 'selenium-webdriver'
  # gem 'capybara-webkit'
end

group :development, :test do
  # gem 'cucumber'
  # gem 'cucumber-sinatra'
  # gem 'rake'
end