require_relative 'differ'

module SubDiff
  class Gsub < Differ
    private

    def diff!(*args, &block)
      match_prefix = ''
      suffix_matcher = args.first.is_a?(Regexp) ? :match : :include?

      diffable.gsub(args.first) do |match|
        suffix = $'
        stripped_prefix = $`.sub(match_prefix, '')
        prefix = stripped_prefix
        replacement = [match.sub(*args, &block), match]

        diffs.push(prefix).push(*replacement)

        unless suffix.send(suffix_matcher, args.first)
          diffs.push(suffix)
        end

        match_prefix << prefix << match
      end
    end
  end
end
