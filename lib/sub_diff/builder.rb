module SubDiff
  class Builder
    attr_reader :string, :type

    def initialize(string, type)
      @string = string
      @type = type
    end

    def diff(*args, &block)
      adapter.diff(*args, &block)
      collection
    end

    def push(*args)
      if args.compact.any?
        diff = Diff.new(*args)
        collection.push(diff)
      end
    end
    alias_method :<<, :push

    private

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

    def collection
      @collection ||= Collection.new(string)
    end
  end
end
