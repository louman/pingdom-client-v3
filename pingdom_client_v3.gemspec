# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "pingdom_client_v3/version"

Gem::Specification.new do |spec|
  spec.name          = "pingdom_client_v3"
  spec.version       = PingdomClientV3::VERSION
  spec.authors       = ["Marcus Mansur"]
  spec.email         = ["mvlouman@gmail.com"]

  spec.summary       = %q{Pure ruby client for Pingdom API V3}
  spec.description   = %q{Pure ruby client for Pingdom API V3}
  spec.homepage      = "https://github.com/louman/pingdom-client-v3"

  spec.files         = Dir['{lib,spec,bin}/**/*', 'README*']
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rest-client"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "guard-rspec", "~> 4.7"
  spec.add_development_dependency "vcr", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 3.1"
  spec.add_development_dependency "byebug"
end
