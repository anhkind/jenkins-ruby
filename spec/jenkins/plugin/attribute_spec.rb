require 'spec_helper'

describe Jenkins::Plugin::Attribute do
  before do
    @test_class = Class.new do
      extend Jenkins::Plugin::Attribute

      attribute :xml_tag, 'value'
    end
  end

  describe '.attributes' do
    it 'stores attribute name in class instance' do
      expect(@test_class.attributes).to include(:xml_tag)
    end
  end

  describe '.attribute' do
    before do
      @object = @test_class.new
    end

    it 'defines attribute getter method' do
      expect(@object).to respond_to(:xml_tag)
    end

    it 'gets the default value on getter method' do
      expect(@object.xml_tag).to eq('value')
    end

    it 'defines attribute setter method' do
      expect(@object).to respond_to(:xml_tag=)
    end

    it 'sets attribute correctly' do
      @object.xml_tag = 'new_value'
      expect(@object.xml_tag).to eq('new_value')
    end
  end
end