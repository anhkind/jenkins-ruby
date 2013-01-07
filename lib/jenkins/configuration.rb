class Jenkins
  class Configuration
    DEFAULT = {
      :port => 8080
    }

    attr_reader :options

    # Initialize a Client object with Jenkins CI server information and credentials
    #
    # @param [Hash] options
    #  * the +:host+     param is the host/ domain/ IP of the Jenkins CI server
    #  * the +:port+     param is the port on which the Jenkins server listens
    #  * the +:username+ param is the username used for connecting to the CI server
    #  * the +:password+ param is the password for connecting to the CI server
    #
    def initialize(options)
      raise "Jenkins::Configuration should be initialized with a Hash" unless options.is_a? Hash
      @options = DEFAULT.merge(options)
    end

    def subset(*keys)
      @options.select{ |k, v| keys.include? k }
    end

    def fetch(*keys)
      @options.values_at(*keys)
    end
  end
end