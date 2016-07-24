# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wda_client/version'

Gem::Specification.new do |spec|
  spec.name          = "wda_client"
  spec.version       = WdaClient::VERSION
  spec.authors       = ["Kazuaki MATSUO"]
  spec.email         = ["fly.49.89.over@gmail.com"]

  spec.summary       = %q{minimal client for WebDriverAgent to help some operations}
  spec.description   = %q{minimal client for WebDriverAgent to help some operations}
  spec.homepage      = "https://github.com/KazuCocoa/wda_client"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "webmock", "~> 2.1"
end
