#require 'active_support/core_ext/string/inflections'

class Jenkins
  class Plugin
    module Attribute
      def self.extended(base)
        base.send(:extend,  ClassMethods)
      end

      module ClassMethods
        def attributes
          @attributes ||= []
        end

        def attribute(name, value)
          #remember the attribute name
          attributes << name

          attr_writer name
          define_method name do
            instance_variable_get("@#{name}") || value
          end
        end
      end
    end
  end
end