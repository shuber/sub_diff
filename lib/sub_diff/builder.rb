module SubDiff
  # Performs a `Sub` or `Gsub` replacement and returns the
  # resulting {Collection} of {Diff} objects.
  #
  # Used internally by {String#sub_diff} and {String#gsub_diff}.
  #
  # @api private
  class Builder
    attr_reader :string, :type

    # @param string [String] the string to perform a replacement on.
    # @param type [Symbol] the type of replacement - :sub or :gsub.
    def initialize(string, type)
      @string = string
      @type = type
    end

    # @return [Collection<Diff>] the resulting diffs from the replacement.
    def diff(*args, &block)
      build_diff_collection do
        adapter.diff(*args, &block)
      end
    end

    def push(*args)
      if args.compact.any?
        diff = Diff.new(*args)
        collection.push(diff)
      end
    end
    alias_method :<<, :push

    private

    def build_diff_collection(&block)
      collection.reset(&block).dup
    end

    def collection
      @collection ||= Collection.new(string)
    end

    def adapter
      @adapter ||= Adapter.new(differ)
    end

    def differ
      @differ ||= Differ.new(self, type)
    end
  end
end
