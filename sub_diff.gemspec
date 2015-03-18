require File.expand_path('../lib/sub_diff/version', __FILE__)

Gem::Specification.new do |s|
  s.author           = 'Sean Huber'
  s.email            = 'github@shuber.io'
  s.extra_rdoc_files = %w(LICENSE)
  s.files            = `git ls-files`.split("\n")
  s.homepage         = 'https://github.com/shuber/sub_diff'
  s.license          = 'MIT'
  s.name             = 'sub_diff'
  s.rdoc_options     = %w(--charset=UTF-8 --inline-source --line-numbers --main README.md)
  s.require_paths    = %w(lib)
  s.summary          = 'Inspect the changes of your `String#sub` and `String#gsub` replacements'
  s.test_files       = `git ls-files -- spec/*`.split("\n")
  s.version          = SubDiff::VERSION

  s.add_dependency 'variables'
  s.add_development_dependency 'codeclimate-test-reporter'
  s.add_development_dependency 'rspec'
end
