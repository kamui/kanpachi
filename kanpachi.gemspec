# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kanpachi/version'

Gem::Specification.new do |spec|
  spec.name          = "kanpachi"
  spec.version       = Kanpachi::VERSION
  spec.authors       = ["Jack Chu"]
  spec.email         = ["kamuigt@gmail.com"]
  spec.description   = %q{Web API DSL}
  spec.summary       = %q{DSL for describing Web APIs}
  spec.homepage      = "htts://github.com/kamui/kanpachi"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'thor'
  spec.add_dependency 'slim'
  spec.add_dependency 'roar'
  spec.add_dependency 'representable'
  spec.add_dependency 'mutations'
  spec.add_dependency 'virtus', '>= 1.0.0.beta7'
  spec.add_dependency 'coercible'
  spec.add_dependency 'kramdown'
  spec.add_dependency 'inflecto'
  spec.add_dependency 'middleman', '>= 3.1.5'
  spec.add_dependency 'slim', '>= 1.3.6'

  # Live-reloading plugin
  spec.add_dependency 'middleman-livereload', '>= 3.1.0'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'guard', '>= 2.0.0.beta.3'
  spec.add_development_dependency 'guard-minitest'

  # For faster file watcher updates on Windows:
  # spec.add_development_dependency 'wdm', '>= 0.1.0'
  # gem "wdm", "~> 0.1.0", :platforms => [:mswin, :mingw]
end
