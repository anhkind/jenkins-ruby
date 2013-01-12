class Jenkins
  class Job
    class Configuration
      def initialize(name, client)
        @name   = name
        @client = client
      end

      def to_xml
        ''
      end

      private
      def load
        response = @client.get("/job/#{@name}/config.xml",
          content_type: 'text/xml'
        )
        @data = response.body if response.success?
        parse(@data)
      end

      def parse(data)

      end
    end
  end
end