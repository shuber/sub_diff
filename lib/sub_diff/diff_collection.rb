require 'delegate'
require 'forwardable'

module SubDiff
  class DiffCollection < SimpleDelegator
    include Enumerable
    extend Forwardable

    def_delegators :diffs, :each, :size

    def initialize(diffs = [])
      super(to_s)
      diffs.each(&method(:<<))
      yield self if block_given?
    end

    def <<(diff)
      if diff.enumerable?
        diffs << diff
        __setobj__(to_s)
      end

      self
    end

    def diffs
      @diffs ||= []
    end

    def to_s
      diffs.join
    end
  end
end
