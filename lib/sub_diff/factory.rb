module SubDiff
  # This class is the only object that knows how to construct
  # all of the other private classes in this library.
  #
  # Used internally by {Buildable} and {CoreExt::String}.
  #
  # @api private
  class Factory
    extend Forwardable

    def_delegator :builder, :diff, :build_diff

    attr_reader :string, :diff_method

    def initialize(string, diff_method)
      @string = string
      @diff_method = diff_method
    end

    def adapter
      @adapter ||= adapter_class.new(self)
    end

    def builder
      @builder ||= Builder.new(self)
    end

    def collection
      @collection ||= Collection.new(string)
    end

    def diff(*args)
      Diff.new(*args)
    end

    def differ
      @differ ||= Differ.new(self)
    end

    private

    def adapter_class
      Module.nesting.last.const_get(adapter_name)
    end

    def adapter_name
      diff_method.to_s.capitalize
    end
  end
end
