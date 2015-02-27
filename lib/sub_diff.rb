require 'sub_diff/diff'
require 'sub_diff/diff_collection'
require 'sub_diff/version'

module SubDiff
  def gsub_diff(*args, &block)
    with_diff_collection do |diff_collection|
      match_prefix, suffix_matcher = '', args.first.is_a?(Regexp) ? :match : :include?
      gsub(args.first) do |match|
        suffix, prefix, replacement = Diff.new($'), Diff.new($`.sub(match_prefix, '')), Diff.new(match.sub(*args, &block), match)
        diff_collection << prefix << replacement
        diff_collection << suffix unless suffix.send(suffix_matcher, args.first)
        match_prefix << prefix + match
      end
    end
  end

  def sub_diff(*args, &block)
    with_diff_collection do |diff_collection|
      sub(args.first) do |match|
        suffix, prefix, replacement = Diff.new($'), Diff.new($`), Diff.new(match.sub(*args, &block), match)
        diff_collection << prefix << replacement << suffix
      end
    end
  end

  private

    def with_diff_collection
      diff_collection = DiffCollection.new
      yield diff_collection
      diff_collection << Diff.new(self) if diff_collection.empty?
      diff_collection
    end
end

String.send(:include, SubDiff)
