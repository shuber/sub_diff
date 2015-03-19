require 'sub_diff/diff'
require 'sub_diff/diff_collection'

module SubDiff
  class DiffBuilder
    attr_reader :default, :diffs

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
    alias_method :<<, :push

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
