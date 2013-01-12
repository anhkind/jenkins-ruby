require 'jenkins/job'

class Jenkins
  def self.map_interface(method, klass)
    define_singleton_method(method) do
      klass.tap do |c|
        c.instance_variable_set('@client', client)
      end
    end
  end

  map_interface :job, Job
end