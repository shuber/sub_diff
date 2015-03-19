require 'sub_diff/diff_builder'
require 'sub_diff/match'

module SubDiff
  class Differ
    attr_reader :diffable, :diff_method

    def initialize(diffable, diff_method)
      @diffable = diffable
      @diff_method = diff_method
    end

    def diff(*args, block)
      collection do |builder|
        diffable.send(diff_method, args.first) do |match|
          # This needs to be called later since it will overwrite
          # the special regex $` (prefix) and $' (suffix) globals
          replacement = proc { match.sub(*args, &block) }
          match = Match.new(match, $`, $', replacement.call)
          yield(builder, match)
        end
      end
    end

    private

    def collection
      builder = DiffBuilder.new(diffable)
      yield(builder)
      builder.collection
    end
  end
end
