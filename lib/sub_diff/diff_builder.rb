require 'sub_diff/diff'
require 'sub_diff/diff_collection'

module SubDiff
  class DiffBuilder
    def initialize(default)
      @default = default
      @diffs = []
    end

    def collection
      DiffCollection.new(diffs_with_default)
    end

    def push(*args)
      if args.compact.any?
        diffs << Diff.new(*args)
      end

      self
    end

    protected

    attr_reader :default, :diffs

    private

    def diffs_with_default
      if diffs.empty?
        dup.push(default).diffs
      else
        diffs
      end
    end
  end
end
