require_relative 'diff_builder'
require_relative 'diff_match'

module SubDiff
  class Differ
    def initialize(diffable)
      @diffable = diffable
    end

    def diff(*args, &block)
      build_diff_collection do
        diff!(*args, &block)
      end
    end

    protected

    attr_reader :diffable, :diffs

    private

    def build_diff_collection
      @diffs = DiffBuilder.new(diffable)
      yield
      diffs.collection.tap { @diffs = nil }
    end

    def diff!(*args, &block)
    end

    def diff_with(method, args, block)
      diffable.send(method, args.first) do |match|
        prefix = $`
        suffix = $'
        replacement = match.sub(*args, &block)
        diff_match = DiffMatch.new(match, replacement, prefix, suffix)

        yield diff_match
      end
    end
  end
end
