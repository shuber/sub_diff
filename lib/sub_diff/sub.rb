require_relative 'differ'

module SubDiff
  class Sub < Differ
    private

    def diff!(*args, &block)
      diffable.sub(args.first) do |match|
        prefix = Diff.new($`)
        suffix = Diff.new($')
        replacement = Diff.new(match.sub(*args, &block), match)

        collection << prefix << replacement << suffix
      end
    end
  end
end
