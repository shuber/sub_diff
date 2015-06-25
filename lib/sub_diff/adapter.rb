module SubDiff
  # Constructs an instance of {Sub} or {Gsub} to be
  # used as a receiver for delegated calls to `diff`.
  #
  # Used internally by {Builder}.
  #
  # @api private
  class Adapter
    include Buildable

    def_delegators :adapter, :diff

    private

    def adapter
      adapter_class.new(factory)
    end

    def adapter_class
      Module.nesting.last.const_get(adapter_name)
    end

    def adapter_name
      diff_method.to_s.capitalize
    end
  end
end
