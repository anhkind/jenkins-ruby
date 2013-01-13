require 'spec_helper'

describe Jenkins::Job::Status do
  before do
    @client = Jenkins::Client.new(options)
  end

  describe 'initialize' do
    it 'is loaded after initializing' do
      Jenkins::Job::Status.any_instance.should_receive(:load!)
      Jenkins::Job::Status.new('name', @client)
    end
  end

  describe 'instance methods' do
    before do
      vcr 'job/status/exist' do
        @status = Jenkins::Job::Status.new('name', @client)
      end
    end

    it 'has status if the job exists' do
      expect(@status.exist?).to be_true
    end

    it 'doesn\'t have any status if the job doesn\'t exist' do
      vcr 'job/status/exist_failed' do
        status = Jenkins::Job::Status.new('non-existing', @client)
        expect(status.exist?).not_to be_true
      end
    end
  end
end