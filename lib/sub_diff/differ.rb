module SubDiff
  # Performs a {String#sub} or {String#gsub} replacement
  # while yielding each match to a block.
  #
  # Used internally by {Sub}.
  #
  # @api private
  class Differ
    extend Forwardable

    def_delegators :builder, :diff_method, :string

    attr_reader :builder

    def initialize(builder)
      @builder = builder
    end

    def each_diff(search, *args, block)
      string.send(diff_method, search) do |match|
        diff = { match: match, prefix: $`, suffix: $' }
        diff[:replacement] = match.sub(search, *args, &block)
        yield(builder, diff)
      end
    end
  end
end
