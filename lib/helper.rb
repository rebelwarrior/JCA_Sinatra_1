# encoding: utf-8

module MyCalendarHelpers  #Controller #< ApplicationController
  def index
    @calendar = ::EventCal::Calendar.new(Date.today)
  end

  def show
    date = Date.parse("#{params[:year]}-#{params[:month]}-#{params[:date]}")
    @calendar = ::EventCal::Calendar.new(date)
  end
end

module PDFsDirectionHelpers
  def pdf_year(year)
    if year.to_s =~ /\A\d{4}\z/
      result = year 
    else 
      result = ''
    end
  end
  
  def area_helper(area)
    %w[air land water general].include?(area) ? area : ''
  end
end

module PressHelpers
  def press_file_lists(public_dir= settings.public_dir)
    press_dir = File.expand_path(public_dir + "/press")
    file_list = Dir.entries(press_dir).sort.select {|f| f.match(/(.*)\.md/)}
    unless file_list.empty?
      # begin
        press_title_list = file_list.map do |f|
          haml_force_encoding f.match(/^[[:digit:]]*_*([[[:word:]]|[-|[[:blank:]]]]+)\.md/).captures.at(0)
        end
        press_file_list = file_list.map {|f| f.match(/(.*)\.md/).captures.at(0)}
        [press_title_list, press_file_list]
      # rescue NoMethodError
      #   raise
      # end
    else 
      [[],[]]
    end
  end
  
  def press_file_relative_to_views()
    if settings.development? 
      "/.." + "/public"+ '/press'
    elsif settings.production?
      "/.." + "/.." + '/press'
    else 
      "/.." + "/public"+ '/press'
    end
  end
  
end

module TextHelpers
  def accents_to_html(text)
    prob_chars = %w[á é í ó ú Á É Í Ó Ú ü Ü ñ Ñ ¿ ¡ ´]
    html_codes = {
      'á' => "&aacute;",
      'é' => "&eacute;",
      'í' => "&iacute;",
      'ó' => "&oacute;",
      'ú' => "&uacute;",
      'Á' => "&Aacute;",
      'É' => "&Eacute;",
      'Í' => "&Iacute;",
      'Ó' => "&Oacute;",
      'Ú' => "&Uacute;",
      'ü' => "&uuml;",
      'Ü' => "&Uuml;",
      'ñ' => "&ntilde;",
      'Ñ' => "&Ntilde;",
      '¿' => "&iquest;",
      '¡' => "&iexcl;",
      '"' => '\"',
      '´' => '&yacute;'   
    }      
    result = text.chars.map do |c|  
      if prob_chars.include?(c)
        html_codes[c]
      elsif c.ascii_only?
        c
      else
        raise "Strage Character Encoding"
      end
    end
   result.join('')
  end
  
  def haml_force_encoding(text)
    text.force_encoding("ASCII-8BIT")
  end
  
  def sanitize(txt)
    txt = txt.split('').select{ |c| c =~ /[a-z]|[0-9]|_/i }.join('')
  end
  
  def dir_listing(path)
    Dir.entries(path.to_s).sort
  end
  
  def t(*args)
    # Calls the I18n translation w/ forced ecoding (a not so simple alias)
    # Might want to do some processing here later to do nav.home to nav_home work.
    haml_force_encoding(I18n.t(*args))
  end
  
  def mobile_user?(agent)
    #idea from: http://keithposehn.net/post/2719977607/detect-mobile-device-with-ruby-for-sinatra-rails
    mobile_agents_small_list = 'blackberry|nokia|mobi|symbian|android|ipod|kindle|webos|ipad|iphone|mini|mobileexplorer|mobile'
    if agent.nil? #nil error found by cucumber test (downcase won't work for nil...)
      false
    elsif agent.downcase =~ Regexp.new(mobile_agents_small_list)
      true
    else
      false
    end
  end
  
  def tel_prefix(agent)
    if agent.nil?
      "tel"
    elsif mobile_user?(agent)
      "tel"
    else
      "callto"
    end
  end
  
  def lang_array(array)
    require 'date'
    array << 'pirate' if Date.today.to_s.match(/\d{4}-09-14/)
    array
  end
  
end
  ### Accesibility to Text ###
  
  # get %r{/([\w]+)\.[txt|md]} do #in Main.app
  #   content_type :plain
  #   logger.info params[:captures] #log requests
  #   req_for_txtpath = sanitize(params[:captures].join('')) unless params[:captures].nil?
  #   path_to_mds= settings.views + '/content'
  #   plaintext = render_plain_text_and_status_code(req_for_txtpath, path_to_mds)
  #   status plaintext[1].to_i
  #   plaintext[0]
  # end  
#   def render_plain_text_and_status_code(path4txt, path_to_md="views/content/")
#     # Also Abstract directory reading to a class variable
#     (@lang['en'] or @lang['es']) ? lang = @lang : lang = 'es'
#     #DONE Possibly add some hardening wrapping this is a Dir.chdir(settings.root + /../)
#     Dir.chdir(File.expand_path("#{settings.root}/../")) do
#       if path4txt == "press"
#         txt_output = File.read("views/content/#{lang}/press.md") + "\n====================\n"
#         Dir.glob('public/press/*.md').each do |file|
#           txt_output << "\s" + file.to_s + "\n\n"
#           txt_output << File.read(file)
#           txt_output << "\n====================\n"
#         end
#         [txt_output, 200]
#       elsif File.exists?("views/content/#{path4txt}.md")
#         [File.read("views/content/#{path4txt}.md"), 200] 
#       elsif File.exists?("views/content/#{lang}/#{path4txt}.md")
#         [File.read("views/content/#{lang}/#{path4txt}.md"), 200]  
#       elsif path4txt =~ /\w/i
#         txt_output = "#{I18n.t('available_options')} \n"
#         Dir.chdir('views/content') do
#           Dir.glob("*.md").each_with_index { |v, i| txt_output << " #{(i + 1)}. #{v}\n"}
#           txt_output << " &. press.md\n"
#           txt_output << "======\n"
#           txt_output << File.expand_path("#{settings.root}/../")
#         end
#         [txt_output, 202]
#       else
#         [not_found, 404]
#       end
#     end
  # end
  