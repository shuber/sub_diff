require_relative 'diff_builder'

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
  end
end
