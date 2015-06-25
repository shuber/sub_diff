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
