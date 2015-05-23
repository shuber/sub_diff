module SubDiff
  class Sub
    def initialize(differ)
      @differ = differ
    end

    def diff(*args, &block)
      # Ruby 1.8.7 does not support additional args after * (splat)
      args.push(block)

      differ.each_diff(*args) do |builder, diff|
        process(builder, diff, args.first)
      end
    end

    private

    attr_reader :differ

    def process(builder, diff, search)
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
