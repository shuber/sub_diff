module SubDiff
  # Constructs an instance of {Sub} or {Gsub} to be
  # used as a receiver for delegated calls to `diff`.
  #
  # Used internally by {Builder}.
  #
  # @api private
  class Adapter
    extend Forwardable

    def_delegators :differ, :builder
    def_delegators :builder, :diff_method
    def_delegators :adapter, :diff

    attr_reader :differ

    def initialize(differ)
      @differ = differ
    end

    private

    def adapter
      adapter_class.new(differ)
    end

    def adapter_class
      Module.nesting.last.const_get(adapter_name)
    end

    def adapter_name
      diff_method.to_s.capitalize
    end
  end
end
