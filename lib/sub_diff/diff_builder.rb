require_relative 'diff'
require_relative 'diff_collection'

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
      diffs << Diff.new(*args)
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
