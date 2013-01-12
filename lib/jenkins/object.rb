class Jenkins
  class Object
    def initialize(*args)
      @client = self.class.instance_variable_get :@client
    end
  end
end