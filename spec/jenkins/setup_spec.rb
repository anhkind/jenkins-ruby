require 'spec_helper'

describe Jenkins do
  describe 'class methods' do
    before do
      @options = {
        host:     'localhost',
        port:     8080,
        username: 'username',
        password: 'password'
      }

      Jenkins.instance_variable_set(:@options, @options)
    end

    describe '.set_client_to' do
      it 'sets the client to some classes ' do
        Jenkins.set_client_to Jenkins::Job
        expect(Jenkins::Job.client).not_to be_nil
      end
    end
  end
end
