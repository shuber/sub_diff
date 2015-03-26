require 'delegate'
require 'forwardable'
require 'sub_diff/diff'

module SubDiff
  class DiffCollection < SimpleDelegator
    extend Forwardable
    include Enumerable

    attr_reader :diffable, :diffs

    def_delegators :diffs, :each, :size

    def initialize(diffable)
      @diffable = diffable
      @diffs = []
      super(diffable)
    end

    def changed?
      diffs.any?(&:changed?)
    end

    def push(*args)
      if args.compact.any?
        diff = Diff.new(*args)
        append(diff)
      end

      self
    end
    alias_method :<<, :push

    private

    def append(diff)
      unless diff.empty?
        @diffs << diff
        __setobj__(diffs.join)
      end
    end
  end
end
