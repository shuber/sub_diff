module SubDiff
  class Differ < Struct.new(:diff_collection, :diff_method)
    class Match < Struct.new(:match, :prefix, :suffix, :replacement)
      alias_method :to_str, :match
    end

    def diff(*args)
      # Ruby 1.8.7 does not support additional args after * (splat)
      block = args.pop

      differ.call(args.first) do |match|
        # This needs to be called later since it will overwrite
        # the special regex $` (prefix) and $' (suffix) globals
        replacement = proc { match.sub(*args, &block) }

        match = Match.new(match, $`, $', replacement.call)
        yield(diff_collection, match)
      end

      diff_collection
    end

    private

    def differ
      diff_collection.diffable.method(diff_method)
    end
  end
end
