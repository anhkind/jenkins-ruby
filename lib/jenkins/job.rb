require 'jenkins/job/configuration'
require 'jenkins/job/status'

class Jenkins
  class Job
    attr_reader :name

    # class methods
    class << self
      def find(name)
        job = new(name, @client)
        job.status && job
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
      @configuration ||= Configuration.new(name, @client)
    end

    def status
      @status ||= Status.new(name, @client)
    end

    def exist?
      response = @client.get("/api/json")
      jobs = response.body["jobs"]
      jobs && jobs.map{|j| j["name"]}.include?(name)
    end

    def save
      api_path = exist? ? "/job/#{name}/config.xml" : "/createItem?name=#{name}"
      @client.post(api_path,
        body:         configuration.to_xml,
        content_type: 'text/xml'
      ).success?
    end

    def destroy
      @client.post("/job/#{name}/doDelete").status == 302
    end

    def reload
      reload!
      self
    end

    def reload!

    end
  end
end