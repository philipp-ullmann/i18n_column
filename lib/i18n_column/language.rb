# Saves the current and default language.
module I18nColumn
  class Language
    DEFAULT_LANG = 'en'
  
    # Returns the current language.
    def self.current_lang
      ::Thread.current[:i18n_column_current_lang] || DEFAULT_LANG
    end
  
    # Sets the current language. Must be set by each request.
    def self.current_lang=(lang)
      ::Thread.current[:i18n_column_current_lang] = lang
    end
  end
end
