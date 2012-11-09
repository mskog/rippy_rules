# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rippy_rules/version'

Gem::Specification.new do |gem|
  gem.name          = "rippy_rules"
  gem.version       = RippyRules::VERSION
  gem.authors       = ["Magnus Skog"]
  gem.email         = ["mrcheese0@gmail.com"]
  gem.description   = "A Ruby library for the What.cd api"
  gem.summary       = "Ruby What.cd API"
  gem.homepage      = %q{https://github.com/MrCheese/rippy_rules}

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "rippy_rules"
  gem.require_paths = ["lib"]
  gem.version       = RippyRules::VERSION

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'mocha'
  gem.add_development_dependency 'guard'
  gem.add_development_dependency 'guard-rspec'
  gem.add_development_dependency 'vcr'
  gem.add_development_dependency 'webmock'

  gem.add_runtime_dependency 'httparty'
end
