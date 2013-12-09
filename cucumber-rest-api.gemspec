# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "cucumber/rest_api/version"

Gem::Specification.new do |s|
  s.name        = "cucumber-rest-api"
  s.version     = Cucumber::RestAPI::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Anupama Vijaykumar,Nic Jackson"]
  s.email       = ["anupama.vijaykumar@marks-and-spencer.com"]
  s.homepage    = "https://github.com/DigitalInnovation/cucumber_rest_api"
  s.summary     = %q{Cucumber steps to easily test REST-based XML and JSON APIs}
  s.description = %q{Cucumber steps to easily test REST-based XML and JSON APIs}

  s.required_ruby_version = '>= 1.9.3'

  s.add_dependency              'jsonpath', '>= 0.1.2'
  s.add_dependency              'nokogiri', '>= 1.6.0'
  s.add_dependency              'cucumber',  '>= 1.2.1'
  s.add_dependency              'rspec',  '>= 2.12.0'

  s.files         = ["lib/cucumber/rest_api.rb","lib/cucumber/rest_api/http_client.rb"]
  s.license = 'MIT'
end