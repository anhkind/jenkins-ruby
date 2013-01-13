require 'hashie'

class Jenkins
  class Job
    class Status
      def initialize(name, client)
        @name   = name
        @client = client
        load!
      end

      def load!
        response = @client.get("/job/#{@name}/api/json")
        if response.success?
          @data = Hashie::Mash.new(response.body)
          @exist = true
        end
      end

      def exist?
        @exist
      end

      def data
        @data
      end
    end
  end
end