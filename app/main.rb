#!/usr/bin/env ruby
# encoding: utf-8

## Load Required Gems ##
# require 'sinatra'
%w[sinatra haml kramdown i18n i18n/backend/fallbacks 
  coffee-script ./lib/helper mongoid].each {|gem| require gem}

### Main Sinatra Class ###
class JCA_Sinatra < Sinatra::Base
  
  helpers TextHelpers 

### Configuration Block ###
  configure do
    mime_type :plain, 'text/plain'
    set :server, :puma
    set :haml, :default_encoding => "UTF-8"
    #Folders
    puts "============#{settings.inspect}==============================="
    set :views, File.expand_path(settings.root + '/../views')
    #settins.root in tomcat is /webapps/<>/WEB-INF/app
  
    ## Internationalization (I18n) 
      I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
      I18n.load_path = I18n.load_path + Dir[File.join(settings.root, 'locales', '*.yml')]
      I18n.backend.load_translations
  end
  configure :production, :development do
    enable :logging
    Mongoid.load!(File.expand_path(settings.root + "/../config/mongoid.yml"))  
  end
  configure :development, :test do
    set :public_dir , File.join(settings.root + '/../public')
  end
  configure :production do
    puts "8888888======PRODUCTION======8888888"
    set :public_dir , File.join(settings.root + '/../../') 
  end
  

###BEFORE ALL###
  #Sets the correct Language for the page.
  before('/:locale/*') do 
    I18n.locale  = params[:locale] if %[es en].include?(params[:locale])
    #prevents requests from pure urls for translations that don't exist.   
    request.path_info = '/' + params[:splat][0]
  end
  
  before do
    @lang = I18n.locale     
    ### PR_GOV_BAR settings ###
    pr_gov_top_bar_height = 40
    @sidebar_offset_num = 250 + pr_gov_top_bar_height
  end
  
    
###ROUTING###  
  get '/' do
    unless ENV['RACK_ENV'] == 'test'
      puts "Hello Sinatra #{request.ip} on env:#{ENV['RACK_ENV']} at dir: #{Dir.pwd}" 
      puts settings.public_dir
    end
    redirect to('/es/home')
  end  
  
  ## Routes:
  get '/about' do
    haml :about
  end
  
  get '/home' do
    # @calendar = MyCalendar::EventCal::Calendar.new(Date.today)
    @max_slideshow_items = 7
    @slideshow_dir = File.expand_path(settings.public_dir + "/images/slideshow")
    @file_list = Dir.entries(@slideshow_dir).sort.select {|f| f.match(/.*\.(png|jpg)/)}
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
  

### FTP Directory for File ###
  get '/home/pdfs' do
    ## Server routes /pdfs via Rack::Directory.new in ../config.ru
    redirect :pdfs
  end
  
  get '/pdf_request?:location' do
    @location = params[:location]
    #add model look up
    redirect :pdfs
  end
  
  get '/dias/:year' do
    @year = params[:year]
    # haml :pdfs, :layout => :errors_layout
    redirect :pdfs
  end
  
  get '/permits/:area' do
    @area = params[:area]
    # haml :pdfs, :layout => :errors_layout
    redirect :pdfs
  end

  get '/laws_and_regulations/:area' do
    @area = params[:area]
    # haml :pdfs, :layout => :errors_layout
    redirect :pdfs
  end
  
  get '/communications/:area' do
    @area = params[:area]
    # haml :pdfs, :layout => :errors_layout
    redirect :pdfs
  end

  get '/googleloginrequired' do
    @lang
    haml :googlelogin, :layout => false
  end
  
  
  ### Accesibility to Text ###
  
  get %r{/([\w]+)\.[txt|md]} do
    content_type :plain
    logger.info params[:captures] #log requests
    req_for_txtpath = sanitize(params[:captures].join('')) unless params[:captures].nil?
    path_to_mds= settings.views + '/content'
    plaintext = render_plain_text_and_status_code(req_for_txtpath, path_to_mds)
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