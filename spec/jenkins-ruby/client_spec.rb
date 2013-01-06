require 'spec_helper'

describe Jenkins::Client do
  describe 'initialize' do
    it 'initializes properly' do
      expect(
        lambda do
          Jenkins::Client.new({
            :host     => 'localhost',
            :port     => 8080,
            :username => 'username',
            :password => 'password'
          })
        end
      ).not_to raise_error
    end

    it 'initializes properly without port param' do
      expect(
        lambda do
          @client = Jenkins::Client.new({
            :host     => 'localhost',
            :username => 'username',
            :password => 'password'
          })
        end
      ).not_to raise_error

      expect(@client.port).to eq(8080)
    end

    it 'does not initialize without host' do
      expect(
        lambda do
          Jenkins::Client.new({
            :port     => 8080,
            :username => 'username',
            :password => 'password'
          })
        end
      ).to raise_error
    end

    it 'does not initialize without username' do
      expect(
        lambda do
          Jenkins::Client.new({
            :host     => 'localhost',
            :port     => 8080,
            :password => 'password'
          })
        end
      ).to raise_error
    end

    it 'does not initialize without password' do
      expect(
        lambda do
          Jenkins::Client.new({
            :host     => 'localhost',
            :port     => 8080,
            :username => 'username'
          })
        end
      ).to raise_error
    end
  end
end
