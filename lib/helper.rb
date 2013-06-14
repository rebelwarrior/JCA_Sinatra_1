# encoding: utf-8
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
    Dir.glob(path.to_s).sort
  end
  
  def t(*args)
    # Calls the I18n translation w/ forced ecoding (a not so simple alias)
    # Might want to do some processing here later to do nav.home to nav_home work.
    haml_force_encoding(I18n.t(*args))
  end
  
  def slideshow_image_file_names(location='public/images/slideshow')
     #Note: the Dir.glob will return nil if not specified correctly. 
     Dir.glob("#{location}/*.{png,jpg}").sort.select do |f|
       m = f.match(%r #{location}/[0-9]*(\w*)\.* )
       m = m.captures.at(0) unless match.nil?
     end
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
  
  def render_plain_text_and_status_code(path4txt, path_to_md="views/content/")
    # Also Abstract directory reading to a class variable
    (@lang['en'] or @lang['es']) ? lang = @lang : lang = 'es'
    #DONE Possibly add some hardening wrapping this is a Dir.chdir(settings.root + /../)
    Dir.chdir(File.expand_path("#{settings.root}/../")) do
      if path4txt == "press"
        txt_output = File.read("views/content/#{lang}/press.md") + "\n====================\n"
        Dir.glob('public/press/*.md').each do |file|
          txt_output << "\s" + file.to_s + "\n\n"
          txt_output << File.read(file)
          txt_output << "\n====================\n"
        end
        [txt_output, 200]
      elsif File.exists?("views/content/#{path4txt}.md")
        [File.read("views/content/#{path4txt}.md"), 200] 
      elsif File.exists?("views/content/#{lang}/#{path4txt}.md")
        [File.read("views/content/#{lang}/#{path4txt}.md"), 200]  
      elsif path4txt =~ /\w/i
        txt_output = "#{I18n.t('available_options')} \n"
        Dir.chdir('views/content') do
          Dir.glob("*.md").each_with_index { |v, i| txt_output << " #{(i + 1)}. #{v}\n"}
          txt_output << " &. press.md\n"
          txt_output << "======\n"
          txt_output << File.expand_path("#{settings.root}/../")
        end
        [txt_output, 202]
      else
        [not_found, 404]
      end
    end
  end
  
  
end
