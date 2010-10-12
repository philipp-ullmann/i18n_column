module I18nColumn
  module Generators
    class InstallGenerator < Rails::Generators::Base

      desc <<DESC
Description:
    Copy initialize file to your application.
DESC

      def self.source_root
        @source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
      end
      
      def copy_initializer_file
        template('config/initializers/i18n_column.rb')
      end
    end
  end
end
