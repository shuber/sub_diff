module SubDiff
  class DiffCollection
    include Enumerable

    def initialize
      @diffs = []
    end

    def <<(diff)
      @diffs << diff
      @to_s = nil
      self
    end

    def each(&block)
      @diffs.each(&block)
    end

    def method_missing(*args, &block)
      to_s.send(*args, &block)
    end

    def to_s
      @to_s ||= @diffs.join
    end
  end
end