# config.ru
require 'rubygems'
require 'sinatra'
require 'bundler'
require 'rack/contrib'

Bundler.require #loads all required gems.

#Allows faster web caching
# use Rack::ETag #Doesn't Work on JRUBY w/ Rack::Deflater https://github.com/rack/rack/issues/571


#Display a directory including a directory listing for ftp like file serving.

# Rack::Directory::DIR_PAGE = "html stuff here + %s is content."
map '/pdfs/' do
  # run Rack::Directory.new('./public/resources/pdfs')
  puts File.dirname(__FILE__) + ":RACK:"
  run Rack::Directory.new(File.expand_path(File.dirname(__FILE__) + '/resources/pdfs'))
  # run Rack::Directory.new('/home/vagrant/Data/public/resources/pdfs')
end
#from: http://lifeascode.com/2013/01/24/the-best-way-to-serve-static-files-from-sinatra/
#also see: https://github.com/rmanalan/heroku-directory-index/blob/master/config.ru

#Allows static pages to be gzip when served.
# use Rack::Deflater #Doesn't Work on JRUBY

#Allows the app to set the default locale to the browser's locale. Part of Rack/contrib.
use Rack::Locale

#Simple prevention of Denial of Service Attacks. Part of Rack/contrib.
use Rack::Deflect, :log => $stdout, :request_threshold => 20, :interval => 2, :block_duration => 60

#TODO: add puma specific code

#Passenger specific code
set :environment, ENV['RACK_ENV'].to_sym
disable :run, :reload


#Runs the Sinatra App
require './app/main.rb'
  run JCA_Sinatra
  
