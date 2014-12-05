# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'better_served_printer/version'

Gem::Specification.new do |spec|
  spec.name          = "better_served_printer"
  spec.version       = BetterServedPrinter::VERSION
  spec.authors       = ["Christoph Klocker"]
  spec.email         = ["christoph@vedanova.com"]
  spec.summary       = %q{Connects to the BetterServed Web Service}
  spec.description   =
  spec.homepage      = "http://better-served.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  # spec.add_development_dependency "debugger"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "fpm"

  # if you modify dependencies, make sure you update scripts/preinstall for the deb packaging
  spec.add_runtime_dependency "pusher-client", ['>= 0.5.0']
  spec.add_runtime_dependency "daemons", ['>= 1.1.9']
end
