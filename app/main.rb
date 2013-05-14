#!/usr/bin/env ruby
# encoding: utf-8

require 'sinatra'
# require 'active_record'
# require 'sinatra/activerecord'
require 'haml'
require 'rdiscount' #markdown
require 'i18n' #internationalization (i18n)
# require 'i18n/backend/fallbacks' #doesn't seem needed.


# require './app/models' 
require './lib/helper'

# require 'gon-sinatra'
require 'sinatra/simple-navigation'

##Main Sinatra Class##
class JCA_Sinatra < Sinatra::Base
  ## Register the Module in the helper file and other helper modules
  # register Gon::Sinatra
  register Sinatra::SimpleNavigation
  helpers TextHelpers 
  
  configure do
    # enable :sessions
    set :views, File.dirname(__FILE__) + '/../views'
    # set :public_folder, File.dirname(__FILE__) + '/../public'
    mime_type :plain, 'text/plain'
    
    #Internationalization (I18n) with Fallbacks & loads YAML files
    I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
    #Locales folder in Sinatra can't easily be changed w/ '/../' so it must be in app.
    I18n.load_path += Dir[File.join(settings.root, 'locales', '*.yml')]
    I18n.backend.load_translations
  end
  configure :production, :development do
    # enable :logging
  end
  

###BEFORE ALL##
  before('/:locale/*') do 
    #Locale set from URL if available else drives from browser default (loaded via Rack Middleware in config.ru).
    #This prevents requests made to translations that don't exist from pure urls. 
    I18n.locale  = params[:locale] if %[es en].include?(params[:locale]) 
    I18n.locale = params[:locale] if (params[:locale] == 'pirate') and (Date.today.mday == 13 and Date.today.month == 9) 
    request.path_info = '/' + params[:splat][0]
  end
  
  before do
    @lang = I18n.locale
    @file_list = []
    pr_gov_top_bar_height = 40
    @sidebar_offset_num = 250 + pr_gov_top_bar_height
  end
  
    
###ROUTING###  
  get '/', :agent => /iPhone|iPad/ do
    puts "Hello Sinatra for iPhone or iPad"
    logger.info "iPhone or iPad agent request"
    redirect :home
  end
  
  get '/' do
    puts "Hello Sinatra #{request.ip}"
    # puts "I18n Locale is #{I18n.locale}"
    # puts Dir[File.join(File.dirname(__FILE__), 'locales', '*.yml').to_s]
    # redirect to('/home?locale=es')
    redirect to('/es/home')
  end  

  get '/about' do
    haml :about
  end
  
  get '/home' do
    Dir.chdir('public') do
      #TODO: Press and Home use similar code must DRY
      #Note: the Dir.glob will return nil if not specified correctly.
      @file_list = Dir.glob('images/slideshow/*.*').sort.select do |f| 
        match = f.match(/(.*)\.(png|jpg)/)
        match = match.captures.at(0) unless match.nil?
      end
    end
    # Dir.chdir('public') do
    #   @file_list = dir_file_name_match('images/slideshow/*.*', /(.*)\.(png|jpg)/)
    # end
    haml :home
  end
  
  get '/areas' do
    haml :areas
  end
  
  ## Press News ##
  get '/press' do
    set :haml, :default_encoding => "UTF-8"
    #Creates an array of file names for submenu 
    #TODO write an rspec for this
    Dir.chdir('public/press') do
      @press_title_list = Dir.glob('*.md').sort.map do |f|
        haml_force_encoding(f.match(/^[[:digit:]]*_*([[[:word:]]|[-|[[:blank:]]]]+)\.md/).captures.at(0))
      end
      @file_list = Dir.glob('*.md').sort.map{|f| f.match(/(.*)\.md/).captures.at(0) }
    end
    haml :press, :format => :html5, :default_encoding => "UTF-8" 
  end
  
  get '/education' do
    haml :education
  end
  
  get '/field_offices' do
    haml :field_offices
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
  
  get '/info' do
    erb markdown(:'internal_divisions_page'), :layout => "top_menu_layout"
  end
    
  get '/mobile' do #separate this to a different app (w/ different views folder)
    if (request.user_agent =~ /iPhone|Android|iPad/i) or (settings.environment == :development)
      erb :mobile
    else
      not_found
    end
  end

  ## FTP Directory for File ##
  ## Server routes /pdfs via Rack::Directory.new in ../config.ru
  get '/home/pdfs' do
    #Mabye create a JS file that calls the html of the rack application and joins it to a body tag?
    redirect :pdfs
  end


  ## Calendar ##
  get '/calendar' do
    # include_gon
    #https://www.googleapis.com/calendar/v3/users/userID/lists?parameters
    #get /calendars/calendarId get /users/me/calendarList/calendarId
    user_key = ENV['GOOGLE_API']
    user_id = ENV['GOOGLE_ID']
    parameters = "key=#{user_key}"
    google_cal_list_resource_path ="https://www.googleapis.com/calendar/v3/users/#{user_id}/calendarList"
    google_cal_colors_resource_path = "https://www.googleapis.com/calendar/v3/colors"
    # gon.calendar_list = "#{google_cal_list_resource_path}?#{parameters}"
    # gon.calendar_colors = "#{google_cal_colors_resource_path}?#{parameters}"
    haml :calendar
  end
  
  get '/admin' do
    request.secure? ? nil : not_found #separate this to a different app.
  end
  
  ### Accesibility to Text ###
  get '/helping/:content' do
    sanitize(params[:content])
  end
  
  get %r{/([\w]+)\.[txt|md]} do
    content_type :plain
    logger.info params[:captures] #log requests
    path4txt = sanitize(params[:captures].join('')) unless params[:captures].nil?
    if path4txt == "press"
      #Possibly add some hardening wrapping this is a Dir.chdir(settings.root + /../)
      txt_output = File.read("views/press.md") + "\n\s"
      Dir.chdir('public/press') do
        Dir.glob('*.md').each do |file|
          txt_output << file.to_s + "\n\s"
          txt_output << File.read(file)
        end
      end
      txt_output
    elsif File.exists?("views/#{path4txt}.md")
      File.read("views/#{path4txt}.md") 
    elsif path4txt =~ /\w/i
      txt_output = "Opciones Disponibles: \n"
      Dir.chdir('views') do
        Dir.glob("*.md").each_with_index { |v, i| txt_output << " #{(i + 1)}. #{v}\n"}
      end
      txt_output
    else
      not_found
    end
  end
  ####
  
  
  #### Error 404 ###
  
  not_found do
    @panda_msg = "Error 404: &iexcl;Que no Panda el C&uacute;nico!"
    @error_msg = "Disculpe, no encontramos la p&aacute;gina buscada."
    @panda_msg + "<br>" + @error_msg
    # haml :404, :layout => :'layouts/errors'
  end
  
end

# JCA_Sinatra.run!