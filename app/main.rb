#!/usr/bin/env ruby
# encoding: utf-8

## Load Required Gems ##
require 'sinatra'
%w[haml kramdown i18n i18n/backend/fallbacks coffee-script].each do |gem| require gem end
require './lib/helper'
# require './lib/sinatra_helper'
# %w['active_record''sinatra/activerecord' './app/models'].each do |gem| require gem end

### Main Sinatra Class ###
class JCA_Sinatra < Sinatra::Base
  
## Register the helper Module in the helper files.
  # register Gon::Sinatra
  helpers TextHelpers 
  # helpers TomcatHelpers

### Configuration Block ###
  configure do
    set :views, File.expand_path(File.dirname(__FILE__) + '/../views')
    warble = false
    set :public_dir, File.expand_path(File.dirname(__FILE__) + '/../public') unless warble
    set :public_dir, File.expand_path(File.dirname(__FILE__) + '/../../public') if warble
        # USE PUBLICDIR so I can reach the public direcory from views!!! REFACTOR
    mime_type :plain, 'text/plain'
    set :server, :puma 
    
    ## Internationalization (I18n) 
    I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
    #Locales folder in Sinatra can't easily be changed w/ '/../' so it must be in app (via settings.root).
    I18n.load_path = I18n.load_path + Dir[File.join(settings.root, 'locales', '*.yml')]
    I18n.backend.load_translations
    
    # Haml::Options.defaults[:encoding] = :utf8
    set :haml, :default_encoding => "UTF-8"
  end
  configure :production, :development do
    enable :logging
  end
  

###BEFORE ALL###
  tomcat = false # if the module is included then tomcat will be a method
  if tomcat
    before('/:tomcat_prefix/*') do
      # gon.prefix = params[:tomcat_prefix]
      # gon.prefix_number = 1
      request.path_info = '/' + params[:splat][0]
    end
  end
  # Preprocessing:
  # refactor to take *.js and [:params] in symbol
  get('/javascripts/app.js'){ coffee :app }
  
  #Sets the correct Language for the page.
  before('/:locale/*') do 
    #Locale set from URL if available else drives from browser default (loaded via Rack Middleware in config.ru).
    I18n.locale  = params[:locale] if %[es en].include?(params[:locale])
    #prevents requests from pure urls for translations that don't exist.  
    I18n.locale = params[:locale] if (params[:locale] == 'pirate') and (Date.today.mday == 13 and Date.today.month == 9) 
    request.path_info = '/' + params[:splat][0]

  end
  
  before do
    @lang = I18n.locale
    @file_list = []
    pr_gov_top_bar_height = 40
    @sidebar_offset_num = 250 + pr_gov_top_bar_height
    @tomcat_prefix = ''
    @tomcat_prefix = prefix_for_tomcat() if tomcat
    #Refactor Content Folder
    # @md_content_location = '' #Where is this used?
  end
  
    
###ROUTING###  
  get '/', :agent => /iPhone|Android|iPad/ do
    puts "Hello Sinatra #{request.ip} on #{ENV['RACK_ENV']} at dir: #{Dir.pwd}" unless ENV['RACK_ENV'] == 'test'
    logger.info "iPhone or iPad agent request"
    redirect to('/es/home')
  end
  
  get '/' do
    puts "Hello Sinatra #{request.ip} on #{ENV['RACK_ENV']} at dir: #{Dir.pwd}" unless ENV['RACK_ENV'] == 'test'
    puts settings.public_dir
    redirect to('/es/home')
  end  

  ## Routes:
  get '/about' do
    haml :about
  end
  
  get '/home' do
    #Refactored! :: Not pretty but it works. Needs further refactoring + test.
      #Note: the Dir.glob will return nil if not specified correctly.
    slideshow_images_path = settings.public_dir + '/images/slideshow/*.*'
    @file_list = Dir.glob(slideshow_images_path).sort.select do |f| 
      match = f.match(/#{settings.public_dir}\/images\/slideshow\/(.*)\.(png|jpg)/)
    end.map do |f|
      match = f.match(/#{settings.public_dir}\/images\/slideshow\/(.*)\.(png|jpg)/)
      match = "#{match.captures.at(0)}.#{match.captures.at(1)}" unless match.nil?
    end
    haml :home
  end

  ## Press News ##
  get '/press' do
    press_dir = settings.public_dir + "/press"
    @press_title_list = []
    @tel_prefix = tel_prefix(request.user_agent)
    @press_title_list = Dir.glob(press_dir + '/*.md').sort.map do |f|
      haml_force_encoding(f.match(/^#{press_dir}\/[[:digit:]]*_*([[[:word:]]|[-|[[:blank:]]]]+)\.md/).captures.at(0))
    end
    @file_list = Dir.glob(press_dir + '/*.md').sort.map{|f| f.match(/^#{press_dir}\/(.*)\.md/).captures.at(0) }
    # This needs to be refactored!! ::TODO the markdown command in view feeds of the location of the views command !
    @press_path_relative_to_views = "../public/press/"
    # The press feeds *must* be stored in a db then.
    haml :press  #, :format => :html5, :default_encoding => "UTF-8" 
  end
  
  get '/areas' do
    haml :areas
  end
  
  get '/education' do
    haml :education
  end
  
  get '/regional_field_offices' do
    haml :regional_field_offices
  end
  
  get '/strategic' do
    haml :strategic
  end
  
  get '/grievances' do
    haml :grievances
  end
  
  get '/beaches' do
    haml :beaches
  end
  
  get '/airquality' do
    haml :air_quality
  end
  
  get '/env_reports' do
    haml :env_reports
  end
  
  get '/calendar' do
    haml :calendar
  end
  
  get '/contact_us' do
    @tel_prefix = tel_prefix(request.user_agent)
    # puts request.user_agent
    haml :contact_us
  end
  
  get '/mobile' do #separate this to a different app (w/ different views folder)
    if (mobile_user?(request.user_agent)) or (settings.environment == :development)
      erb :mobile
    else
      not_found
    end
  end

### FTP Directory for File ###
  get '/home/pdfs' do
    ## Server routes /pdfs via Rack::Directory.new in ../config.ru
    #Mabye create a JS file that calls the html of the rack application and joins it to a body tag? --DONE
    redirect :pdfs
  end
  
  get '/pdf_request?:location' do
    @location = params[:location]
    #add model look up
    redirect :pdfs
  end
  
  get '/dias/:year' do
    @year = params[:year]
    haml :pdfs, :layout => :errors_layout
  end
  
  get '/permits/:area' do
    @area = params[:area]
    haml :pdfs, :layout => :errors_layout
  end

  get '/laws_and_regulations/:area' do
    @area = params[:area]
    haml :pdfs, :layout => :errors_layout
  end
  
  get '/communications/:area' do
    @area = params[:area]
    haml :pdfs, :layout => :errors_layout
  end

  get '/googleloginrequired' do
    haml :googlelogin, :layout => false
  end

  get '/admin' do
    request.secure? ? nil : not_found #separate this to a different app.
  end
  
  
  ### Accesibility to Text ###
  
  get %r{/([\w]+)\.[txt|md]} do
    content_type :plain
    logger.info params[:captures] #log requests
    request_for_txt_path = sanitize(params[:captures].join('')) unless params[:captures].nil?
    path_to_mds= 'views/content'
    plaintext = render_plain_text_and_status_code(request_for_txt_path, path_to_mds)
    status plaintext[1].to_i
    plaintext[0]
  end
  ####
  
  
  #### Error 404 ###
  
  not_found do
    #TODO INTERNATIONALIZE
    @request_url = request.url
    haml :'404', :layout => :errors_layout
  end
  
  run! if __FILE__ == $0
end

__END__