require 'jenkins/job/configuration'

class Jenkins
  class Job
    attr_reader :name, :client

    # class methods
    class << self
      def find(name)

      end

      def all

      end
    end

    def initialize(name, client = nil)
      @name   = name
      @client = client || self.class.instance_variable_get(:@client)

      raise NotFoundError unless @name && !@name.empty?
      raise NotFoundError unless @client
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def exist?
      false
    end

    def destroy
      client.post("/job/#{name}/doDelete",
        content_type: 'text/xml'
      ).status == 302
    end

    def save
      if exist?
        # update job
        # ...
      else
        # create job
        client.post("/createItem?name=#{name}",
          body:         configuration.to_xml,
          content_type: 'text/xml'
        ).success?
      end
    end

    def reload
      reload!
      self
    end

    def reload!

    end
  end
end