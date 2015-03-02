require 'delegate'

module SubDiff
  class Diff < SimpleDelegator
    attr_reader :value_was

    alias_method :value, :__getobj__

    def initialize(value, value_was = nil)
      @value_was = value_was || value
      super(value)
    end

    def changed?
      value != value_was
    end

    def empty?
      super && !changed?
    end
  end
end
