module SubDiff
  # Performs a {String#sub} or {String#gsub} replacement
  # while yielding each match "diff payload" to a block.
  #
  # The payload contains:
  #
  #   match       - the string matching the search.
  #   prefix      - the string preceding the match.
  #   suffix      - the string trailing the match.
  #   replacement - the string replacing the match.
  #
  # This class uses some special global variables: $` and $'.
  # See http://ruby-doc.org/core-2.2.0/doc/globals_rdoc.html
  #
  # Used internally by {Sub}.
  #
  # @api private
  class Differ
    include Buildable

    def each_diff(search, *args, block)
      string.send(diff_method, search) do |match|
        diff = { match: match, prefix: $`, suffix: $' }
        diff[:replacement] = match.sub(search, *args, &block)
        yield(diff)
      end
    end
  end
end
