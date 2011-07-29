module SubDiff
  class Diff
    attr_reader :value, :value_was
    alias_method :to_s, :value

    def initialize(value, value_was = nil)
      @value, @value_was = value, value_was || value
    end

    def changed?
      @changed ||= value != value_was
    end

    def method_missing(*args, &block)
      to_s.send(*args, &block)
    end
  end
end