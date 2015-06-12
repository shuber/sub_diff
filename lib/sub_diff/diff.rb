module SubDiff
  # Stores a single match (and optional replacement)
  # from a {String#sub} or {String#gsub} replacement.
  #
  # It behaves just like a {String} and represents the
  # newly replaced string if a replacement was made, or
  # the matched string itself if no changes occurred.
  #
  # It also has additional methods that provide access
  # to the old string, the newly replaced string, and a
  # boolean to determine if a replacement was actually made.
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
