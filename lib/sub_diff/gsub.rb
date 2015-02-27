require_relative 'differ'

module SubDiff
  class Gsub < Differ
    private

    def diff!(*args, &block)
      match_prefix = ''
      suffix_matcher = args.first.is_a?(Regexp) ? :match : :include?

      diffable.gsub(args.first) do |match|
        suffix = Diff.new($')
        stripped_prefix = $`.sub(match_prefix, '')
        prefix = Diff.new(stripped_prefix)
        replacement = Diff.new(match.sub(*args, &block), match)

        collection << prefix << replacement

        unless suffix.send(suffix_matcher, args.first)
          collection << suffix
        end

        match_prefix << prefix << match
      end
    end
  end
end
