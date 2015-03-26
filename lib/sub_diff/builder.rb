require 'forwardable'
require 'sub_diff/collection'
require 'sub_diff/differ'
require 'sub_diff/gsub'

module SubDiff
  class Builder < Struct.new(:string, :type)
    extend Forwardable

    def_delegators :instance, :diff

    private

    def instance
      builder.new(differ)
    end

    def builder
      Module.nesting.last.const_get(constant)
    end

    def constant
      type.to_s.capitalize
    end

    def differ
      Differ.new(collection, type)
    end

    def collection
      Collection.new(string)
    end
  end
end
