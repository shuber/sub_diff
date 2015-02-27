require_relative 'differ'

module SubDiff
  class Gsub < Differ
    private

    def diff!(*args, &block)
      match_prefix, suffix_matcher = '', args.first.is_a?(Regexp) ? :match : :include?

      diffable.gsub(args.first) do |match|
        suffix, prefix, replacement = Diff.new($'), Diff.new($`.sub(match_prefix, '')), Diff.new(match.sub(*args, &block), match)
        collection << prefix << replacement
        collection << suffix unless suffix.send(suffix_matcher, args.first)
        match_prefix << prefix + match
      end
    end
  end
end
