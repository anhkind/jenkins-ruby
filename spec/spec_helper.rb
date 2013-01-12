require "jenkins-ruby"
require "vcr"

SPEC_ROOT = File.join(Jenkins::ROOT, 'spec')

Dir[File.join(SPEC_ROOT, "support", "**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.before(:each) do

  end

  config.include RSpecHelpers
end

VCR.configure do |c|
  c.cassette_library_dir = SPEC_ROOT + '/fixtures/vcr_cassettes'
  c.hook_into :faraday
  c.allow_http_connections_when_no_cassette = true
  c.debug_logger = File.new(SPEC_ROOT + '/vcr.log', 'w')
end