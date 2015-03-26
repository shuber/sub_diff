require 'sub_diff/diff_builder'

module SubDiff
  module CoreExt
    module String
      def sub_diff(*args, &block)
        DiffBuilder.new(self, :sub).diff(*args, &block)
      end

      def gsub_diff(*args, &block)
        DiffBuilder.new(self, :gsub).diff(*args, &block)
      end
    end
  end
end
