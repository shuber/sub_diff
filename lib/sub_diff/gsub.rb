require_relative 'differ'

module SubDiff
  class Gsub < Differ
    private

    def diff!
      match_prefix = ''
      suffix_matcher = args.first.is_a?(Regexp) ? :match : :include?

      diff_with(:gsub, args, block) do |match|
        prefix = match.prefix.sub(match_prefix, '')

        diffs.push(prefix).push(match.replacement, match)

        unless match.suffix.send(suffix_matcher, args.first)
          diffs.push(match.suffix)
        end

        match_prefix << prefix << match
      end
    end
  end
end
