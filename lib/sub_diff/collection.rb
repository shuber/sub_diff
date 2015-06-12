module SubDiff
  # Stores a collection of {Diff} objects for all matches from
  # a {String#sub_diff} or {String#gsub_diff} replacement.
  #
  # It behaves like a {String} that represents the entire
  # replacement result from {String#sub} or {String#gsub}.
  #
  # It also behaves like an {Enumerable} by delegating to
  # {Collection#diffs} - an {Array} containing each {Diff}.
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
