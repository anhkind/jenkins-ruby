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

    describe '#[]' do
      it 'accesses status through [] method' do
        expect(@status['name']).not_to be_nil
        expect(@status['displayName']).not_to be_nil
      end
    end

    describe '#exist?' do
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

    describe '#load!' do
      it 'loads the status from the server' do
        vcr 'job/status/load' do
          @status.instance_variable_set(:@exist, false)
          expect(@status.exist?).not_to be_true

          @status.load!
          expect(@status.exist?).to be_true
        end
      end
    end
  end
end