require 'delegate'
require 'forwardable'

module SubDiff
  class DiffCollection < SimpleDelegator
    extend Forwardable
    include Enumerable

    attr_reader :diffs

    def_delegators :diffs, :each, :size

    def initialize(diffs)
      @diffs = diffs.reject(&:empty?)
      super(diffs.join)
    end

    def changed?
      diffs.any?(&:changed?)
    end
  end
end
