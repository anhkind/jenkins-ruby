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

    describe '#exist?' do
      it 'exists on server' do
        vcr 'job/exist' do
          expect(@job.exist?).to be_true
        end
      end

      it 'does not exist on server' do
        vcr 'job/exist_failed' do
          expect(@job.exist?).not_to be_true
        end
      end
    end

    describe '#save' do
      it 'is saved to server if it\'s a new job (not exist)' do
        @job.stub(:exist?).and_return(false)
        vcr 'job/save_new' do
          expect(@job.save).to be_true
        end
      end

      it 'is saved to server if it\'s a existing job' do
        @job.stub(:exist?).and_return(true)
        vcr 'job/save_existing' do
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
