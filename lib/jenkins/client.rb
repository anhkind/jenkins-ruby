class Jenkins
  class Client
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
      raise ArgumentError, "Jenkins::Client should be initialized with a Hash"        unless options.is_a? Hash

      options.each do |key, value|
        instance_variable_set("@#{key}", value) if value
      end

      raise ArgumentError, "Host is required to connect to Jenkins Server"            unless @host
      raise ArgumentError, "Port is required to connect to Jenkins Server"            unless @port
      raise ArgumentError, "Credentials are required to connect to te Jenkins Server" unless @username && @password
    end
  end
end