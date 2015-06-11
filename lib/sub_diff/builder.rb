module SubDiff
  class Builder
    def initialize(string, type)
      @string = string
      @type = type
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

    attr_reader :string, :type

    def build_diff_collection(&block)
      collection.reset(&block).dup
    end

    def collection
      @collection ||= Collection.new(string)
    end

    def adapter
      adapter_class.new(differ)
    end

    def adapter_class
      Module.nesting.last.const_get(adapter_name)
    end

    def adapter_name
      type.to_s.capitalize
    end

    def differ
      Differ.new(self, type)
    end
  end
end
