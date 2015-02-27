require 'sub_diff/diff'
require 'sub_diff/diff_collection'
require 'sub_diff/version'

module SubDiff
  def gsub_diff(*args, &block)
    diff_collection do |collection|
      match_prefix, suffix_matcher = '', args.first.is_a?(Regexp) ? :match : :include?
      gsub(args.first) do |match|
        suffix, prefix, replacement = Diff.new($'), Diff.new($`.sub(match_prefix, '')), Diff.new(match.sub(*args, &block), match)
        collection << prefix << replacement
        collection << suffix unless suffix.send(suffix_matcher, args.first)
        match_prefix << prefix + match
      end
    end
  end

  def sub_diff(*args, &block)
    diff_collection do |collection|
      sub(args.first) do |match|
        suffix, prefix, replacement = Diff.new($'), Diff.new($`), Diff.new(match.sub(*args, &block), match)
        collection << prefix << replacement << suffix
      end
    end
  end

  private

  def diff_collection(&block)
    DiffCollection.new(&block).tap do |collection|
      if collection.empty?
        collection << Diff.new(self)
      end
    end
  end
end

String.send(:include, SubDiff)
