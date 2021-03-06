require 'spec_helper'

describe Jenkins::Configuration do
  describe 'initialize' do
    it 'initializes properly' do
      expect(
        lambda do
          Jenkins::Configuration.new({
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
          Jenkins::Configuration.new('123')
        end
      ).to raise_error
    end

    it 'sets to default port' do
      config = Jenkins::Configuration.new({
        host:     'localhost',
        username: 'username',
        password: 'password'
      })

      expect(config.options[:port]).to eq(8080)
    end
  end

  describe 'instance methods' do
    before do
      @configuration = Jenkins::Configuration.new({
        host:     'localhost',
        port:     8080,
        username: 'username',
        password: 'password'
      })
    end

    describe '#subset' do
      it 'gets the subset correctly' do
        subset = @configuration.subset(:host, :port)
        expect(subset).to eq( host: 'localhost', port: 8080 )
      end
    end

    describe '#fetch' do
      it 'fetches list of values from list of keys' do
        values = @configuration.fetch(:host, :port)
        expect(values).to eq( ['localhost', 8080] )
      end
    end
  end
end
