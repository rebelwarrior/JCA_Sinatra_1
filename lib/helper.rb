# encoding: utf-8
module TextHelpers
  def accents_to_html(text)
    prob_chars = %w[á é í ó ú Á É Í Ó Ú ü Ü ñ Ñ ¿ ¡ & ´]
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
      '´' => '&yacute;',
      '&' => "&amp;"    
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
    # Just a simple alias
    # Might want to do some processing here later to do nav.home to nav_home work.
    haml_force_encoding(I18n.t(*args))
  end
end

=begin
module SimpleNavigation
  module Renderer
    class BootstrapBreadcrumbs < SimpleNavigation::Renderer::Base

      def render(item_container)
        content_tag(:ul, li_tags(item_container).join(join_with), { id: item_container.dom_id, class: item_container.dom_class })
      end

      protected

      def li_tags(item_container)
        item_container.items.inject([]) do |list, item|
          if item.selected?
            if include_sub_navigation?(item)
              list << content_tag(:li, link_to(item.name, item.url, {method: item.method}.merge(item.html_options.except(:class,:id)))) if item.selected?
              list.concat li_tags(item.sub_navigation)
            else
              list << content_tag(:li, item.name, { class: 'active' }) if item.selected?
            end
          end
          list
        end
      end

      def join_with
        @join_with ||= options[:join_with] || '/'
        content_tag(:li, content_tag(:span, @join_with, :class => 'divider'))
      end
    end
  end
end
SimpleNavigation.register_renderer :bootstrap_breadcrumbs => SimpleNavigation::Renderer::BootstrapBreadcrumbs
=end