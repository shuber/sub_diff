module SubDiff
  # Stores a collection of {Diff} objects for all matches
  # from {String#sub_diff} or {String#gsub_diff} replacement.
  #
  # It behaves like a {String} with added {Enumerable} behavior
  # that delegates to an internal {Array} of {Diff} objects.
  #
  # @api public
  class Collection < SimpleDelegator
    extend Forwardable
    include Enumerable

    def_delegators :diffs, :each, :size

    attr_reader :string, :diffs

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
      self
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
