require_relative 'differ'

module SubDiff
  class Gsub < Differ
    private

    def diff!
      current_prefix = ''

      diff_with(:gsub) do |match|
        prefix = match.prefix.sub(current_prefix, '')
        diffs.push(prefix).push(match.replacement, match)
        diffs.push(match.suffix) if suffix?(match)
        current_prefix << prefix << match
      end
    end

    def suffix?(match)
      !match.suffix.send(suffix_matcher, args.first)
    end

    def suffix_matcher
      case args.first
      when Regexp
        :match
      else
        :include?
      end
    end
  end
end
