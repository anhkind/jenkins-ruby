require "jenkins-ruby"

SPEC_ROOT = File.join(Jenkins::ROOT, 'spec')

Dir[File.join(SPEC_ROOT, "support", "**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.before(:each) do

  end

  config.include RSpecHelpers
end