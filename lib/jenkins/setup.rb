class Jenkins
  def self.set_client_to(*klasses)
    klasses.each do |klass|
      klass.instance_variable_set(:@client, client)
    end
  end

  def self.setup_client
    set_client_to Job, Job::Configuration, Job::Status
  end
end