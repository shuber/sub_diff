module SubDiff
  class Collection < SimpleDelegator
    extend Forwardable
    include Enumerable

    attr_reader :string, :diffs

    def_delegators :diffs, :each, :size

    def initialize(string)
      @string = string
      @diffs = []
      super(string)
    end

    def changed?
      diffs.any?(&:changed?)
    end

    def push(diff)
      unless diff.empty?
        diffs << diff
        __setobj__(diffs.join)
      end
    end
  end
end