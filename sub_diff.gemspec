# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'sub_diff/version'
require 'date'

Gem::Specification.new do |s|
  s.name     = 'sub_diff'
  s.version  = SubDiff::Version
  s.date     = Date.today
  s.platform = Gem::Platform::RUBY

  s.summary     = ''
  s.description = ''

  s.author   = 'Sean Huber'
  s.email    = 'shuber@huberry.com'
  s.homepage = 'http://github.com/shuber/sub_diff'

  s.require_paths = ['lib']

  s.files      = Dir['{bin,lib}/**/*'] + %w(MIT-LICENSE Rakefile README.rdoc)
  s.test_files = Dir['test/**/*']

  s.add_dependency('respond_to_missing')
end