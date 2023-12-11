lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "act_with_flags/version"

Gem::Specification.new do |s|
  s.name = "act_with_flags"
  s.version = ActWithFlags::VERSION
  s.summary = %(act_with_flags gem)
  s.description = %(Handles flags/booleans in a Rails model instance)
  s.authors = ["Dittmar Krall"]
  s.email = ["dittmar.krall@matiq.com"]
  s.homepage = "https://github.com/matique/act_with_flags"

  s.license = "MIT"
  s.platform = Gem::Platform::RUBY
  s.metadata["source_code_uri"] = "https://github.com/matique/act_with_flags"

  s.files = `git ls-files -z`.split("\x0")
  s.require_paths = ["lib"]

  s.add_development_dependency "appraisal", ">= 0"
  s.add_development_dependency "combustion", ">= 0"
  s.add_development_dependency "minitest", ">= 0"
  s.add_development_dependency "sqlite3", ">= 0"
end
