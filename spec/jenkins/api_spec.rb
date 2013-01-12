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

      Jenkins.configure(@options)
    end

    describe '.job' do
      it 'gets Job class through API method' do
        expect(Jenkins.job).to be(Jenkins::Job)
      end

      it 'has @client instance variable' do
        job = Jenkins.job.new('job name')
        expect(job.instance_variable_get(:@client)).not_to be_nil
      end
    end
  end
end
