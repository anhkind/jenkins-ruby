module Jenkins
  class Client
    DEFAULT = {
      :port => 8080
    }

    attr_reader :host, :port
    # Initialize a Client object with Jenkins CI server information and credentials
    #
    # @param [Hash] args
    #  * the +:host+     param is the host/ domain/ IP of the Jenkins CI server
    #  * the +:port+     param is the port on which the Jenkins server listens
    #  * the +:username+ param is the username used for connecting to the CI server
    #  * the +:password+ param is the password for connecting to the CI server
    #
    def initialize(args)
      DEFAULT.merge(args).each do |key, value|
        instance_variable_set("@#{key}", value) if value
      end

      raise "Host is required to connect to Jenkins Server"            unless @host
      raise "Credentials are required to connect to te Jenkins Server" unless @username && @password

      @port ||= DEFAULT_SERVER_PORT
    end
  end
end