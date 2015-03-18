require 'forwardable'
require 'variables'
require_relative 'diff_builder'

module SubDiff
  class Sub
    extend Forwardable

    def initialize(diffable)
      @builder = DiffBuilder.new(diffable)
      @args = nil
      @block = nil
      @diffs = nil
      @match = nil
      @prefix = nil
      @suffix = nil
    end

    def diff(*args, &block)
      variables = { args: args, block: block, diffs: builder.dup }

      instance_variable_replace(variables) do
        diff! { process }
        diffs.collection
      end
    end

    protected

    attr_reader :args, :block
    attr_reader :builder, :diffs
    attr_reader :match, :prefix, :suffix

    def_delegator :builder, :default, :diffable

    def diff_method
      :sub
    end

    private

    def diff!
      diffable.send(diff_method, args.first) do |match|
        variables = { match: match, prefix: $`, suffix: $' }
        instance_variable_replace(variables) { yield }
      end
    end

    def process
      diffs.push(prefix).push(replacement, match).push(suffix)
    end

    def replacement
      match.sub(*args, &block)
    end
  end
end
