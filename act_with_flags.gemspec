lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'act_with_flags/version'

Gem::Specification.new do |s|
  s.name        = 'act_with_flags'
  s.version     = ActWithFlags::VERSION
  s.summary     = %(act_with_flags gem)
  s.description = %(Handles flags in a Rails model instance)
  s.authors     = ['Dittmar Krall']
  s.email       = ['dittmar.krall@matique.de']
  s.homepage    = 'http://matique.de'

  s.license     = 'MIT'
  s.platform    = Gem::Platform::RUBY

  s.files         = `git ls-files -z`.split("\x0")
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'appraisal'
  s.add_development_dependency 'combustion'

  s.add_development_dependency 'minitest'
  s.add_development_dependency 'sqlite3'
end
