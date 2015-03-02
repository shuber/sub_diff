require 'delegate'

module SubDiff
  class DiffMatch < SimpleDelegator
    attr_reader :prefix, :suffix, :replacement

    alias_method :match, :__getobj__

    def initialize(match, replacement, prefix, suffix)
      @replacement = replacement
      @prefix = prefix
      @suffix = suffix
      super(match)
    end
  end
end
