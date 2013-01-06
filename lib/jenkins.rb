require "jenkins/configuration"
require "jenkins/client"

class Jenkins
  ROOT = File.join(File.dirname(__FILE__), '..')

  def initialize(options)
    @options = options
  end

  def configuration
    @configuration ||= Configuration.new(@options)
  end

  def client
    @client ||= Client.new(configuration.subset(:host, :port, :username, :password))
  end
end