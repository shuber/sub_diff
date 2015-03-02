require_relative 'differ'

module SubDiff
  class Sub < Differ
    private

    def diff!
      diff_with(:sub) do |match|
        diffs
          .push(match.prefix)
          .push(match.replacement, match)
          .push(match.suffix)
      end
    end
  end
end
