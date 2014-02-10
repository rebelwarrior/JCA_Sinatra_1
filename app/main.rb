#!/usr/bin/env ruby
# encoding: utf-8

## Load Required Gems ##
%w[sinatra haml kramdown i18n i18n/backend/fallbacks 
   coffee-script ./lib/helper mongoid date].each {|gem| require gem}

### Main Sinatra Class ###
class JCA_Sinatra < Sinatra::Base
  
  helpers TextHelpers 
  helpers PDFsDirectionHelpers
  helpers PressHelpers

### Configuration Block ###
  configure do
    mime_type :plain, 'text/plain'
    set :server, :puma
    set :haml, :default_encoding => "UTF-8"
    #settins.root in tomcat is /webapps/<>/WEB-INF/app
    set :views, File.expand_path(settings.root + '/../views')
  
    ## Internationalization (I18n) 
      I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
      I18n.load_path = I18n.load_path + Dir[File.join(settings.root, 'locales', '*.yml')]
      I18n.backend.load_translations
    ## Internationalization (I18n) 
  end
  configure :production, :development do
    enable :logging
    Mongoid.load!(File.expand_path(settings.root + "/../config/mongoid.yml"))  
  end
  configure :development, :test do
    set :public_dir , File.join(settings.root + '/../public')
  end
  configure :production do
    set :public_dir , File.join(settings.root + '/../../') 
  end
  

###BEFORE ALL###
  #Sets the correct Language for the page.
  before('/:locale/*') do 
    I18n.locale  = params[:locale] if lang_array(%[es en]).include?(params[:locale])
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
    @tel_prefix = tel_prefix(request.user_agent)
    @press_title_list, @press_file_list = press_file_lists(settings.public_dir)
    @press_path_relative_to_views = press_file_relative_to_views()
    # TODO: The press feeds *must* be stored in a db then.
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
    haml :contact_us
  end
  

### FTP Directory for File ###
  get '/home/pdfs' do
    ## Server routes /pdfs via Rack::Directory.new in ../config.ru
    redirect :pdfs
  end
  
  # get '/pdf_request?:location' do
  #   @location = params[:location]
  #   #add model look up
  #   redirect :pdfs
  # end
  
  get '/dias/:year' do
    @year = params[:year]
    redirect "pdfs/dias/#{pdf_year @year}"
  end
  
  get '/permits/:area' do
    @area = params[:area]
    redirect "pdfs/permits/#{area_helper @area}"
  end

  get '/laws_and_regulations/:area' do
    @area = params[:area]
    redirect "pdfs/laws_and_regulations/#{@area}"
  end
  
  get '/communications/:area' do
    @area = params[:area]
    redirect "pdfs/communications/#{@area}"
  end

  get '/googleloginrequired' do
    @lang
    haml :googlelogin, :layout => false
  end
  
  ####
  
  
  #### Error 404 ###
  
  not_found do
    @request_url = request.url
    haml :'404', :layout => :errors_layout
  end
  
  run! if __FILE__ == $0
end

__END__