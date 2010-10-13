# Saves the current and default language.
module I18nColumn
  class Language
    @@default_lang = 'en'
    
    # Sets the default language.
    def self.default_lang=(lang)
      @@default_lang = lang
    end
    
    # Returns the current language.
    def self.current_lang
      ::Thread.current[:i18n_column_current_lang] || @@default_lang
    end
  
    # Sets the current language. Must be set by each request.
    def self.current_lang=(lang)
      ::Thread.current[:i18n_column_current_lang] = lang
    end
  end
end
