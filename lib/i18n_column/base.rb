# This extension provides the capabilities of storing and retrieving translations from a single database column.
# The translations are serialized using JSON i.e. {"en":"Spindle axes","de":"Spindelachsen"}.
# 
# Example
# 
# class Node < ActiveRecord::Base
#   i18n_column(:name)
# end
module I18nColumn
  module Base
    def self.included(base)
      base.extend(ClassMethods)
    end
  
    module ClassMethods
      # Creates i18n getter and setter methods for the given column names.
      def i18n_column(*col_names)
        for col_name in col_names
          class_eval <<-EOV
            def #{col_name}
              json = decode_#{col_name}
              json.nil? ? nil : json[::I18n.locale.to_s]
            end
            
            def #{col_name}=(value)
              json = decode_#{col_name} || {}
              json[::I18n.locale.to_s] = value
              self[:#{col_name}] = json.to_json
              value
            end
            
            def f#{col_name}
              self.#{col_name}
            end
            
            def f#{col_name}=(value)
              self.#{col_name} = value
            end
            
            private
            
            def decode_#{col_name}
              val = self[:#{col_name}]
              (val.inspect == "nil" || val.to_s.blank?) ? nil : ::ActiveSupport::JSON::decode(val.to_s)
            end
          EOV
        end
      end
    end
  end
end

ActiveRecord::Base.class_eval { include I18nColumn::Base }
