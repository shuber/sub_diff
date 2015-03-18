require File.expand_path('../lib/sub_diff/version', __FILE__)

Gem::Specification.new do |s|
  s.name     = 'sub_diff'
  s.version  = SubDiff::VERSION
  s.platform = Gem::Platform::RUBY

  s.summary     = 'Inspect the changes of your `String#sub` and `String#gsub` replacements'
  s.description = 'A closer inspection of the changes from `String#sub` and `String#gsub` replacements'

  s.author   = 'Sean Huber'
  s.email    = 'github@shuber.io'
  s.homepage = 'https://github.com/shuber/sub_diff'
  s.license  = 'MIT'

  s.require_paths = ['lib']

  s.files      = Dir['{bin,lib}/**/*'] + %w(Gemfile LICENSE README.rdoc)
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'variables'
  s.add_development_dependency 'codeclimate-test-reporter'
  s.add_development_dependency 'rspec'
end
