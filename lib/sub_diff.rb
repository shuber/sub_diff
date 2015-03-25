require 'sub_diff/diff_collection'
require 'sub_diff/differ'
require 'sub_diff/gsub'
require 'sub_diff/version'

module SubDiff
  def sub_diff(*args, &block)
    diff_with(Sub, *args, &block)
  end

  def gsub_diff(*args, &block)
    diff_with(Gsub, *args, &block)
  end

  private

  def diff_with(constant, *args, &block)
    method = diff_method(constant)
    differ = differ(method)
    instance = constant.new(differ)
    instance.diff(*args, &block)
  end

  def diff_method(constant)
    constant.name.split('::').last.downcase.to_sym
  end

  def differ(method)
    Differ.new(diff_collection, method)
  end

  def diff_collection
    DiffCollection.new(self)
  end
end

String.send(:include, SubDiff)
