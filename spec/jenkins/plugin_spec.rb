require 'spec_helper'
require "nokogiri"

describe Jenkins::Plugin do
  before do
    @plugin_class = Class.new(Jenkins::Plugin) do
      attribute :a, 'value'
      attribute :b, false

      def to_xml(builder)
        super(builder)
        builder.to_xml
      end
    end
  end

  describe 'instance methods' do
    before do
      @plugin = @plugin_class.new
    end

    describe '#to_xml' do
      before do
        @builder = Nokogiri::XML::Builder.new
        @plugin.instance_variable_set(:@xml_root, 'project')
      end

      it 'creates xml correctly from attribute declaration' do
        xml = @plugin.to_xml(@builder)
        expect(xml).to include('<a>value</a>')
        expect(xml).to include('<b>false</b>')
      end
    end
  end
end