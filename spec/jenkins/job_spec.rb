require 'spec_helper'

describe Jenkins::Job do
  before do
    @options = {
      #host:     'localhost',
      host:     '192.168.0.17',
      port:     8080,
      username: 'username',
      password: 'password'
    }
  end

  describe 'class methods' do
    before do
      Jenkins.configure(@options)
    end
  end

  describe '#initialize' do
    before do
      @client = mock
    end

    it 'initializes with name and client' do
      expect {
        @job = Jenkins::Job.new('name', @client)
      }.not_to raise_error
    end

    it 'initializes with name and client (from class variable)' do
      Jenkins::Job.instance_variable_set(:@client, @client)
      expect {
        @job = Jenkins::Job.new('name')
      }.not_to raise_error
      #remove instance variable in class
      Jenkins::Job.instance_variable_set(:@client, nil)
    end

    it 'initializes with error with blank name' do
      expect {
        @job = Jenkins::Job.new('', @client)
      }.to raise_error
    end

    it 'initializes with error if name is nil' do
      expect {
        @job = Jenkins::Job.new(nil, @client)
      }.to raise_error
    end

    it 'initializes with error if client is nil' do
      expect {
        @job = Jenkins::Job.new('name', nil)
      }.to raise_error
    end

    it 'initializes with error if not client provided at all (in argument and class variable)' do
      expect {
        @job = Jenkins::Job.new('name')
      }.to raise_error
    end
  end

  describe 'instance methods' do
    before do
      @client = Jenkins::Client.new(@options)
      @job = Jenkins::Job.new('name', @client)
      @job.configuration.stub(:to_xml).and_return(content(file('blank_config.xml')))
    end

    describe '#save' do
      it 'saves job to server' do
        vcr 'job/save' do
          expect(@job.save).to be_true
        end
      end
    end

    describe '#destroy' do
      it 'destroys the job on server' do
        vcr 'job/destroy' do
          expect(@job.destroy).to be_true
        end
      end
    end
  end
end