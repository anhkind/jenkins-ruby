require "faraday"

class Jenkins
  class Client < Faraday::Connection
    attr_reader :host, :port
    # Initialize a Client object with Jenkins CI server information and credentials
    #
    # @param [Hash] options
    #  * the +:host+     param is the host/ domain/ IP of the Jenkins CI server
    #  * the +:port+     param is the port on which the Jenkins server listens
    #  * the +:username+ param is the username used for connecting to the CI server
    #  * the +:password+ param is the password for connecting to the CI server
    #
    def initialize(options)
      raise TypeError, "Jenkins::Client should be initialized with a Hash" unless options.is_a? Hash

      options.each do |key, value|
        instance_variable_set("@#{key}", value) if value
      end

      raise "Host is required to connect to Jenkins Server"            unless @host
      raise "Port is required to connect to Jenkins Server"            unless @port
      raise "Credentials are required to connect to te Jenkins Server" unless @username && @password

      super(url: "http://#@host:#@port")
    end

    [:get, :post, :put, :delete].each do |http_method|
      define_method(http_method) do |path, params = {}|
        content_type = params.delete(:content_type)
        body         = params.delete(:body)
        basic_auth(@username, @password)
        response = super(URI::encode(path)) do |req|
          req.headers['Content-Type'] = content_type if content_type
          req.body                    = body         if body
        end
        response
      end
    end
  end
end