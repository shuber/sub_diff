module SubDiff
  class Differ < Struct.new(:diff_collection, :diff_method)
    def diff(*args)
      # Ruby 1.8.7 does not support additional args after * (splat)
      block = args.pop

      differ.call(args.first) do |match|
        diff = { :match => match, :prefix => $`, :suffix => $' }
        diff[:replacement] = match.sub(*args, &block)
        yield(diff_collection, diff)
      end

      diff_collection
    end

    private

    def differ
      diff_collection.string.method(diff_method)
    end
  end
end
