module SubDiff
  class Adapter
    extend Forwardable

    def_delegators :differ, :builder
    def_delegators :builder, :type
    def_delegators :instance, :diff

    attr_reader :differ

    def initialize(differ)
      @differ = differ
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