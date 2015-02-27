require_relative 'differ'

module SubDiff
  class Sub < Differ
    private

    def diff!(*args, &block)
      diffable.sub(args.first) do |match|
        suffix, prefix, replacement = Diff.new($'), Diff.new($`), Diff.new(match.sub(*args, &block), match)
        collection << prefix << replacement << suffix
      end
    end
  end
end
