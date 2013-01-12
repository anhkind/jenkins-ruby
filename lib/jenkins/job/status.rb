require 'hashie'

class Jenkins
  class Job
    class Status
      def initialize(name, client)
        @name   = name
        @client = client
        load
      end

      private
      def load
        response = @client.get("/job/#{@name}/api/json")
        @data    = response.body if response.success?
        @data && parse(@data)
      end

      def parse(data)
        Hashie::Mash.new(data)
      end
    end
  end
end