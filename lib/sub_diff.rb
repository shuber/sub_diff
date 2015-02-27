require 'sub_diff/diff'
require 'sub_diff/diff_collection'
require 'sub_diff/gsub'
require 'sub_diff/version'

module SubDiff
  def sub_diff(*args, &block)
    Sub.new(self).diff(*args, &block)
  end

  def gsub_diff(*args, &block)
    Gsub.new(self).diff(*args, &block)
  end
end

String.send(:include, SubDiff)
