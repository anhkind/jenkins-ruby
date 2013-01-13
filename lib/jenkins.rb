require "jenkins/configuration"
require "jenkins/client"

class Jenkins
  ROOT = File.join(File.dirname(__FILE__), '..')

  def self.configure(options)
    @options = options
    @configuration = @client = nil #clear previous setting objects
    setup_client
  end

  def self.configuration
    @configuration ||= Configuration.new(@options)
  end

  def self.client
    @client ||= Client.new(configuration.subset(:host, :port, :username, :password))
  end
end

require "jenkins/objects"
require "jenkins/setup"