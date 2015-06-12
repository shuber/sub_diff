module SubDiff
  # Stores a single match (and optional replacement)
  # from {String#sub} or {String#gsub} replacements.
  #
  # It behaves just like a {String} but has some additional
  # methods that provides references to the old string,
  # the newly replaced string, and a boolean to check
  # if a replacement was actually made.
  #
  # @api public
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
      value.empty? && !changed?
    end
  end
end
