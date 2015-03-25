module SubDiff
  class Sub < Struct.new(:differ)
    def diff(*args, &block)
      # Ruby 1.8.7 does not support additional args after * (splat)
      args.push(block)

      differ.diff(*args) do |builder, match|
        process(builder, match, args.first)
      end
    end

    private

    def process(builder, match, search)
      builder << prefix(match)
      builder.push(match.replacement, match)
      builder << suffix(match, search)
    end

    def prefix(match)
      match.prefix
    end

    def suffix(match, _search)
      match.suffix
    end
  end
end
