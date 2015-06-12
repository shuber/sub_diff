module SubDiff
  # Processes matches for {String#sub} replacements
  # to build up a {Collection} of {Diff} objects.
  #
  # Used internally by {Adapter}.
  #
  # @api private
  class Sub
    attr_reader :differ

    def initialize(differ)
      @differ = differ
    end

    def diff(search, *args, &block)
      differ.each_diff(search, *args, block) do |builder, diff|
        process(builder, diff, search)
      end
    end

    private

    def process(builder, diff, search)
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
