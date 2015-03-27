# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'railsworks/version'

Gem::Specification.new do |spec|
  spec.name          = "railsworks"
  spec.version       = Railsworks::VERSION
  spec.authors       = ["Kurt Nelson"]
  spec.email         = ["kurtisnelson@gmail.com"]
  spec.summary       = %q{Useful rake tasks for apps deployed with OpsWorks}
  spec.description   = %q{Console and deploy task for OpsWorks}
  spec.homepage      = "https://github.com/kurtisnelson/railsworks"
  spec.license       = "GPL"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
