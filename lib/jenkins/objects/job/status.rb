class Jenkins
  class Job
    class Status < Object
      def initialize(name, client)
        @name   = name
        @client = client
        load!
      end

      def [](key)
        @data[key]
      end

      def load!
        response = client.get("/job/#{@name}/api/json")
        if response.success?
          @data = response.body
          @exist = true
        end
      end
      alias_method :reload!, :load!

      def exist?
        @exist
      end

      def data
        @data
      end
    end
  end
end