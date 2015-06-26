class SubDiff
  module CoreExt
    module String
      # Behaves just like {String#sub} but wraps the returned replacement
      # string in an enumerable {Collection} of {Diff} objects.
      #
      # See http://ruby-doc.org/core-2.2.0/String.html#method-i-sub
      def sub_diff(*args, &block)
        SubDiff.new(self, :sub).diff(*args, &block)
      end

      # Behaves just like {String#gsub} but wraps the returned replacement
      # string in an enumerable {Collection} of {Diff} objects.
      #
      # See http://ruby-doc.org/core-2.2.0/String.html#method-i-gsub
      def gsub_diff(*args, &block)
        SubDiff.new(self, :gsub).diff(*args, &block)
      end
    end
  end
end
