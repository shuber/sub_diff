module SubDiff
  class DiffCollection
    include Enumerable

    def initialize(diffs = [])
      @diffs = []
      diffs.each { |diff| self << diff }
    end

    def <<(diff)
      if diff.changed? || !diff.empty?
        @diffs << diff
        @to_s = nil
      end
      self
    end

    def each(&block)
      @diffs.each(&block)
    end

    def method_missing(*args, &block)
      to_s.send(*args, &block)
    end

    def respond_to_missing?(method, include_private)
      to_s.respond_to?(method, include_private)
    end

    def size
      @diffs.size
    end

    def to_s
      @to_s ||= @diffs.join
    end
  end
end