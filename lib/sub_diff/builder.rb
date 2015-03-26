module SubDiff
  class Builder < Struct.new(:string, :type)
    def diff(*args, &block)
      builder.diff(*args, &block)
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

    def builder
      constant.new(differ)
    end

    def constant
      Module.nesting.last.const_get(constant_name)
    end

    def constant_name
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
