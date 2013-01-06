require "jenkins-ruby/configuration"
require "jenkins-ruby/client"

class Jenkins
  ROOT = File.join(File.dirname(__FILE__), '..')

  def initialize(args)
    @args = args
  end

  def configuration
    @configuration ||= Configuration.new(@args)
  end

  def client
    @client ||= Client.new(configuration)
  end
end