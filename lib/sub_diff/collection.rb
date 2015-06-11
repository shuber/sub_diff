module SubDiff
  class Collection < SimpleDelegator
    extend Forwardable
    include Enumerable

    attr_reader :string, :diffs

    def_delegators :diffs, :each, :size
    def_delegators :__getobj__, :to_s

    def initialize(string)
      @string = string
      @diffs = []
      super(string)
    end

    def changed?
      diffs.any?(&:changed?)
    end

    def clear
      diffs.clear
      __setobj__('')
    end

    def push(diff)
      unless diff.empty?
        diffs << diff
        __setobj__(diffs.join)
      end
    end

    def reset
      clear
      __setobj__(string)
      yield if block_given?
      self
    end
  end
end
