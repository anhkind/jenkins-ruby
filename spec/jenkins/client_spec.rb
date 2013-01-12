require 'spec_helper'

describe Jenkins::Client do
  describe 'initialize' do
    it 'initializes properly' do
      expect(
        lambda do
          Jenkins::Client.new({
            host:     'localhost',
            port:     8080,
            username: 'username',
            password: 'password'
          })
        end
      ).not_to raise_error
    end

    it 'does not initialize if options are not Hash' do
      expect(
        lambda do
          Jenkins::Client.new('123')
        end
      ).to raise_error
    end

    it 'does not initialize without host' do
      expect(
        lambda do
          Jenkins::Client.new({
            port:     8080,
            username: 'username',
            password: 'password'
          })
        end
      ).to raise_error
    end

    it 'does not initialize without port' do
      expect(
        lambda do
          @client = Jenkins::Client.new({
            host:     'localhost',
            username: 'username',
            password: 'password'
          })
        end
      ).to raise_error
    end

    it 'does not initialize without username' do
      expect(
        lambda do
          Jenkins::Client.new({
            host:     'localhost',
            port:     8080,
            password: 'password'
          })
        end
      ).to raise_error
    end

    it 'does not initialize without password' do
      expect(
        lambda do
          Jenkins::Client.new({
            host:     'localhost',
            port:     8080,
            username: 'username',
          })
        end
      ).to raise_error
    end
  end

  describe 'HTTP requests' do
    before do
      @stubs = Faraday::Adapter::Test::Stubs.new do |stub|
        stub.get('/path')    { [200, {}, 'ok'] }
        stub.post('/path')   { [200, {}, 'ok'] }
        stub.put('/path')    { [200, {}, 'ok'] }
        stub.delete('/path') { [200, {}, 'ok'] }
      end
      @client = Jenkins::Client.new({
        host:     'localhost',
        port:     8080,
        username: 'username',
        password: 'password'
      }) do |builder|
        builder.adapter :test, @stubs
      end
    end

    it 'should send GET request' do
      response = @client.get('/path')
      expect(response.body).to include("ok")
    end

    it 'should send POST request' do
      response = @client.post('/path')
      expect(response.body).to include("ok")
    end

    it 'should send PUT request' do
      response = @client.put('/path')
      expect(response.body).to include("ok")
    end

    it 'should send DELETE request' do
      response = @client.delete('/path')
      expect(response.body).to include("ok")
    end
  end
end
