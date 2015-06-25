require 'delegate'
require 'forwardable'
require 'sub_diff/buildable'
require 'sub_diff/builder'
require 'sub_diff/collection'
require 'sub_diff/diff'
require 'sub_diff/differ'
require 'sub_diff/factory'
require 'sub_diff/sub'
require 'sub_diff/gsub'
require 'sub_diff/version'
require 'sub_diff/core_ext/string'

String.send(:include, SubDiff::CoreExt::String)

# Performs a {String#sub} or {String#gsub} replacement and wraps the
# returned string in an enumerable {Collection} of {Diff} objects.
#
# Used internally by {CoreExt::String#sub_diff} and {CoreExt::String#gsub_diff}.
#
# @api private
class SubDiff
  def initialize(string, diff_method)
    @factory = Factory.new(string, diff_method)
  end

  def diff(*args, &block)
    @factory.builder.diff(*args, &block)
  end
end
