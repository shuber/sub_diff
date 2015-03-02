require_relative 'differ'

module SubDiff
  class Sub < Differ
    private

    def diff!(*args, &block)
      diffable.sub(args.first) do |match|
        prefix = $`
        suffix = $'
        replacement = [match.sub(*args, &block), match]

        diffs.push(prefix).push(*replacement).push(suffix)
      end
    end
  end
end
