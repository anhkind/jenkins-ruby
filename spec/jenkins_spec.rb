require 'spec_helper'

describe Jenkins do
  describe 'initialize' do
    context 'with no error' do
      before do
        @options = {
          host:     'localhost',
          port:     8080,
          username: 'username',
          password: 'password'
        }
      end

      it 'initializes properly' do
        expect(
          lambda do
            Jenkins.configure(@options)
          end
        ).not_to raise_error
      end

      it 'initializes configuration properly' do
        expect(
          lambda do
            Jenkins.configure(@options)
            Jenkins.configuration
          end
        ).not_to raise_error
      end

      it 'initializes client properly' do
        expect(
          lambda do
            Jenkins.configure(@options)
            Jenkins.client
          end
        ).not_to raise_error
      end
    end
  end
end
