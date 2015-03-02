require 'forwardable'
require_relative 'cache'
require_relative 'diff_builder'

module SubDiff
  class Sub
    extend Forwardable
    include Cache

    def initialize(diffable)
      @builder = DiffBuilder.new(diffable)
    end

    def diff(*args, &block)
      cache(args: args, block: block, diffs: builder.dup) do
        diff! { process }
        diffs.collection
      end
    end

    protected

    attr_reader :args, :block
    attr_reader :builder, :diffs
    attr_reader :match, :replacement, :prefix, :suffix

    def_delegator :builder, :default, :diffable

    def diff_method
      :sub
    end

    private

    def diff!
      diffable.send(diff_method, args.first) do |match|
        cache(prefix: $`, suffix: $', match: match) do
          replacement = match.sub(*args, &block)
          cache(replacement: replacement) { yield }
        end
      end
    end

    def process
      diffs.push(prefix).push(replacement, match).push(suffix)
    end
  end
end
