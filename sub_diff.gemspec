require File.expand_path('../lib/sub_diff/version', __FILE__)

Gem::Specification.new do |s|
  s.name     = 'sub_diff'
  s.version  = SubDiff::Version
  s.platform = Gem::Platform::RUBY

  s.summary     = 'Apply regular expression replacements to strings while presenting the result in a "diff" like format'
  s.description = 'Allows you to apply regular expression replacements to strings while presenting the result in a "diff" like format'

  s.author   = 'Sean Huber'
  s.email    = 'github@shuber.io'
  s.homepage = 'https://github.com/shuber/sub_diff'
  s.license  = 'MIT'

  s.require_paths = ['lib']

  s.files      = Dir['{bin,lib}/**/*'] + %w(Gemfile MIT-LICENSE README.rdoc)
  s.test_files = Dir['spec/**/*']

  s.add_development_dependency 'codeclimate-test-reporter'
  s.add_development_dependency 'rspec'
end
