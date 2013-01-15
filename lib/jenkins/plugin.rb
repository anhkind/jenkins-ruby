require "jenkins/plugin/attribute"

class Jenkins
  class Plugin
    extend Attribute

    def to_xml(builder)
      plugin     = self
      attributes = self.class.attributes
      builder.send(@xml_root) do
        attributes.each do |attribute|
          attribute.respond_to?(:to_xml) ? attribute.to_xml(builder) : builder.send(attribute, plugin.send(attribute))
        end
      end
    end
  end
end