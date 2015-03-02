require 'delegate'

module SubDiff
  class DiffMatch < SimpleDelegator
    attr_reader :replacement, :prefix, :suffix

    alias_method :match, :__getobj__

    def initialize(match, replacement, prefix, suffix)
      @replacement = replacement
      @prefix = prefix
      @suffix = suffix
      super(match)
    end
  end
end
