class Jenkins
  class Object
    class << self
      attr_accessor :client

      def children
        @children ||= []
      end

      def inherited(child)
        Object.children << child
      end

    end

    attr_reader :client
  end
end