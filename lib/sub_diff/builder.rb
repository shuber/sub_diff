module SubDiff
  # Performs a {Sub} or {Gsub} replacement and returns
  # the resulting {Collection} of {Diff} objects.
  #
  # Used internally by {CoreExt::String#sub_diff} and {CoreExt::String#gsub_diff}.
  #
  # @api private
  class Builder
    include Buildable

    def diff(*args, &block)
      build_diff_collection do
        adapter.diff(*args, &block)
      end
    end

    def push(*args)
      if args.compact.any?
        diff = factory.diff(*args)
        collection.push(diff)
      end
    end
    alias_method :<<, :push

    private

    def build_diff_collection(&block)
      collection.reset(&block).dup
    end
  end
end
