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
    txt = txt.split('').select{ |c| c =~ /[a-z]|[0-9]/i }.join('')
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
  
end
