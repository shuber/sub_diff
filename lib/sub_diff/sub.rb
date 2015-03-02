require_relative 'differ'

module SubDiff
  class Sub < Differ
    private

    def diff!(*args, &block)
      diff_with(:sub, args, block) do |match|
        diffs
          .push(match.prefix)
          .push(match.replacement, match)
          .push(match.suffix)
      end
    end
  end
end
