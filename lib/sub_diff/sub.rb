module SubDiff
  class Sub < Struct.new(:differ)
    def diff(*args, &block)
      # Ruby 1.8.7 does not support additional args after * (splat)
      args.push(block)

      differ.diff(*args) do |builder, diff|
        diff!(builder, diff, args.first)
      end
    end

    private

    def diff!(builder, diff, search)
      builder << prefix(diff)
      builder.push(diff[:replacement], diff[:match])
      builder << suffix(diff, search)
    end

    def prefix(diff)
      diff[:prefix]
    end

    def suffix(diff, _search)
      diff[:suffix]
    end
  end
end
