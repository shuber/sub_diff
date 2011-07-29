require 'rubygems'
require 'bundler/setup'
require 'test/unit'

$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$:.unshift(File.dirname(__FILE__))
require 'sub_diff'