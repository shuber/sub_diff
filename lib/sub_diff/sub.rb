module SubDiff
  # Processes matches for {String#gsub} replacements
  # by pushing diffs into a {Builder} instance.
  #
  # Used internally by {Adapter}.
  #
  # @api private
  class Sub
    include Buildable

    def diff(search, *args, &block)
      differ.each_diff(search, *args, block) do |diff|
        process(diff, search)
      end
    end

    private

    def process(diff, search)
      builder << prefix(diff)
      builder.push(diff[:replacement], diff[:match])
      builder << suffix(diff, search)
    end

    def prefix(diff)
      diff[:prefix]
    end

    def suffix(diff, _search)
      diff[:suffix]
    end
  end
end
