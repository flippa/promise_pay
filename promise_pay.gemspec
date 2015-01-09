# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'promise_pay/version'

Gem::Specification.new do |spec|
  spec.name          = "promise_pay"
  spec.version       = PromisePay::VERSION
  spec.authors       = ["Liam Norton"]
  spec.email         = ["liam.norton@flippa.com"]
  spec.summary       = %q{PromisePay gem}
  spec.description   = %q{PromisePay gem for API calls wrapped in Ruby}
  spec.homepage      = "https://github.com/iamliamnorton/promise_pay"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_runtime_dependency "activesupport", ">= 2.3"
  spec.add_runtime_dependency "json"
  spec.add_runtime_dependency "rest-client", "~> 1.7"
end
