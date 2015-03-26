module SubDiff
  module CoreExt
    module String
      def sub_diff(*args, &block)
        Builder.new(self, :sub).diff(*args, &block)
      end

      def gsub_diff(*args, &block)
        Builder.new(self, :gsub).diff(*args, &block)
      end
    end
  end
end
