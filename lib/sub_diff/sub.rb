require 'sub_diff/differ'

module SubDiff
  class Sub
    attr_reader :diffable

    def initialize(diffable)
      @diffable = diffable
    end

    def diff(*args, &block)
      # Ruby 1.8.7 does not support additional args after * (splat)
      args.push(block)

      differ.diff(*args) do |builder, match|
        process(builder, match, args.first)
      end
    end

    private

    def differ
      Differ.new(diffable, diff_method)
    end

    def diff_method
      :sub
    end

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
