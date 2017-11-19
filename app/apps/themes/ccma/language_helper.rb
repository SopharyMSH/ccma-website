module Themes::Ccma::LanguageHelper
  def self.included(klass)
    klass.helper_method [:ccma_language] rescue ""
  end

  def ccma_language(lang)
    locales = %w(en km cn).map { |l| l.prepend '/'  }
    if is_post_type?
      "#{@post_type.the_url.sub(Regexp.union(locales), '')}/?locale=#{lang}"
    else
      url_for(locale: :"#{lang}")
    end
  end
end
