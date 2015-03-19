require 'sub_diff/differ'

module SubDiff
  class Sub
    attr_reader :diffable

    def initialize(diffable)
      @diffable = diffable
    end

    def diff(*args, &block)
      differ.diff(*args, block) do |builder, match|
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
      prefix = prefix(match)
      suffix = suffix(match, search)

      builder.push(prefix)
      builder.push(match.replacement, match)
      builder.push(suffix)
    end

    def prefix(match)
      match.prefix
    end

    def suffix(match, _search)
      match.suffix
    end
  end
end
