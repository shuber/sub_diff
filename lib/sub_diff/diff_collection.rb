require 'delegate'
require 'forwardable'

module SubDiff
  class DiffCollection < SimpleDelegator
    include Enumerable
    extend Forwardable

    def_delegators :diffs, :each, :size

    def initialize(diffs = [])
      if diffs.empty?
        super to_s
      else
        diffs.each { |diff| self << diff }
      end
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
