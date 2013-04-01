# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'oauth_twitter/version'

Gem::Specification.new do |spec|
  spec.name          = "oauth_twitter"
  spec.version       = OauthTwitter::VERSION
  spec.authors       = ["Daiwei Lu"]
  spec.email         = ["daiweilu123@gmail.com"]
  spec.description   = %q{Simple twitter oauth api to add methods to module for rails module.}
  spec.summary       = %q{Include module to add methods for rails module.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency             'rack', '>= 1.4.5'
end
