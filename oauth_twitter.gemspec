# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'oauth_twitter/version'

Gem::Specification.new do |spec|
  spec.name          = "oauth_twitter"
  spec.version       = OauthTwitter::VERSION
  spec.authors       = ["Daiwei Lu"]
  spec.email         = ["daiweilu123@gmail.com"]
  spec.description   = %q{An OAuth library to interact with Twitter API v1.1, by simply calling methods on instances.}
  spec.summary       = %q{Load data from Twitter API}
  spec.homepage      = "https://github.com/daiweilu/oauth_twitter"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency             'rack', '>= 1.4.5'
  spec.add_dependency             'multi_json', '~> 1.7'
end
