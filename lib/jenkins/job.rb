require 'jenkins/object'

class Jenkins
  class Job < Object
    attr_reader :name

    # class methods
    class << self
      def find(name)

      end

      def all

      end
    end

    def initialize(name)
      @name = name
      super
    end

    def configuration

    end

    def destroy

    end

    def save

    end

    def reload
      reload!
      self
    end

    def reload!

    end
  end
end