# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/version'

Gem::Specification.new do |spec|
  spec.name          = "rack-ip-authorizer"
  spec.version       = RackIpAuthorizer::VERSION
  spec.authors       = ['Thibault El Zamek, Cédric Darné, Lionel Oto']
  spec.email         = ['thibault.elzamek@c4mprod.com, cedric.darne@c4mprod.com, lionel.oto@c4mprod.com']
  spec.description   = %q{Basic Rack middleware for checking Rails3 request remote ip}
  spec.summary       = %q{Basic Rack middleware for checking Rails3 request remote ip}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files = Dir[*%w( LICENSE.txt README.md lib/**/* )]
  spec.test_files = Dir['spec/**/*']
  spec.require_paths = ["lib"]

  spec.add_dependency 'rack', '>= 1.0'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake', '>= 1.0'
  spec.add_development_dependency 'rack-test', '~> 0.6.2'
end
