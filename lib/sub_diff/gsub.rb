require_relative 'sub'

module SubDiff
  class Gsub < Sub
    def diff(*args, &block)
      diff_collection do |collection|
        match_prefix, suffix_matcher = '', args.first.is_a?(Regexp) ? :match : :include?

        string.gsub(args.first) do |match|
          suffix, prefix, replacement = Diff.new($'), Diff.new($`.sub(match_prefix, '')), Diff.new(match.sub(*args, &block), match)
          collection << prefix << replacement
          collection << suffix unless suffix.send(suffix_matcher, args.first)
          match_prefix << prefix + match
        end
      end
    end
  end
end
