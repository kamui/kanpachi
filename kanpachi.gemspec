# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kanpachi/version'

Gem::Specification.new do |spec|
  spec.name          = "kanpachi"
  spec.version       = Kanpachi::VERSION
  spec.authors       = ["Jack Chu"]
  spec.email         = ["kamuigt@gmail.com"]
  spec.summary       = %q{DSL for describing Web APIs and generating documentation}
  spec.description   = %q{Provides a DSL to describe your web API, generate documentation, and will eventually help you implement it.}
  spec.homepage      = "https://github.com/kamui/kanpachi"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'thor'
  spec.add_dependency 'roar'
  spec.add_dependency 'representable'
  spec.add_dependency 'mutations'
  spec.add_dependency 'virtus'
  spec.add_dependency 'coercible'
  spec.add_dependency 'kramdown'
  spec.add_dependency 'inflecto'
  spec.add_dependency 'middleman'
  spec.add_dependency 'slim'

  # Live-reloading plugin
  spec.add_dependency 'middleman-livereload'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-minitest'

  # For faster file watcher updates on Windows:
  # spec.add_development_dependency 'wdm', '>= 0.1.0'
  # gem "wdm", "~> 0.1.0", :platforms => [:mswin, :mingw]
end
