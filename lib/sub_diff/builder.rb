module SubDiff
  class Builder
    attr_reader :string, :diff_method

    def initialize(string, diff_method)
      @string = string
      @diff_method = diff_method
    end

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
      @differ ||= Differ.new(self)
    end
  end
end
