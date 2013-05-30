# config.ru
require 'bundler'
Bundler.require #loads all required gems.

#Display a directory including a directory listing for ftp like file serving.
map "/pdfs" do
  run Rack::Directory.new("./public/resources/pdfs")
end
#from: http://lifeascode.com/2013/01/24/the-best-way-to-serve-static-files-from-sinatra/

#Allows static pages to be gzip when served.
use Rack::Deflater

#Allows the app to set the default locale to the browser's locale. Part of Rack/contrib.
use Rack::Locale

#Simple prevention of Denial of Service Attacks. Part of Rack/contrib.
use Rack::Deflect, :log => $stdout, :request_threshold => 20, :interval => 2, :block_duration => 60

#TODO: add puma specific code

#Runs the Sinatra App
require './app/main.rb'
  run JCA_Sinatra
