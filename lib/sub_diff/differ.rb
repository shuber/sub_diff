module SubDiff
  class Differ < Struct.new(:collection, :type)
    def diff(*args)
      # Ruby 1.8.7 does not support additional args after * (splat)
      block = args.pop

      differ.call(args.first) do |match|
        diff = { :match => match, :prefix => $`, :suffix => $' }
        diff[:replacement] = match.sub(*args, &block)
        yield(collection, diff)
      end

      collection
    end

    private

    def differ
      collection.string.method(type)
    end
  end
end
