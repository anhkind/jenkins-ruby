# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jenkins/version'

Gem::Specification.new do |gem|
  gem.name          = "jenkins-ruby"
  gem.version       = Jenkins::VERSION
  gem.authors       = ["anhkind"]
  gem.email         = ["anhkind@gmail.com"]
  gem.description   = %q{Utilities to connect to Jenkins CI through Remote Access API}
  gem.summary       = %q{Utilities to connect to Jenkins CI through Remote Access API}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency             "faraday",             ">= 0.7.0"
  gem.add_dependency             "faraday_middleware",  ">= 0.8"
  gem.add_dependency             "active_support",      ">= 3.0.0"
  gem.add_dependency             "nokogiri"

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec", ">= 2.11"
  gem.add_development_dependency "vcr"
end