module SubDiff
  class Adapter
    extend Forwardable

    def_delegators :@builder, :differ, :type
    def_delegators :instance, :diff

    def initialize(builder)
      @builder = builder
    end

    private

    def instance
      adapter_class.new(differ)
    end

    def adapter_class
      Module.nesting.last.const_get(adapter_name)
    end

    def adapter_name
      type.to_s.capitalize
    end
  end
end
