require_relative 'diff'
require_relative 'diff_collection'

module SubDiff
  class Differ
    def initialize(diffable)
      @diffable = diffable
      @collection = DiffCollection.new
    end

    def diff(*args, &block)
      diff!(*args, &block)

      if collection.empty?
        collection << Diff.new(diffable)
      end

      collection
    end

    private

    attr_reader :diffable, :collection

    def diff!(*args, &block)
    end
  end
end
