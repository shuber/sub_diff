require 'rake'
require 'rake/testtask'
require 'rdoc/task'

desc 'Default: run unit tests'
task :default => :test

desc 'Test the sub_diff gem'
Rake::TestTask.new(:test) do |t|
  t.libs += ['lib', 'test']
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the sub_diff gem'
RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'sub_diff'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end