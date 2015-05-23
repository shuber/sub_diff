module SubDiff
  class Differ
    extend Forwardable

    def_delegators :builder, :string

    def initialize(builder, type)
      @builder = builder
      @type = type
    end

    def each_diff(*args)
      # Ruby 1.8.7 does not support additional args after * (splat)
      block = args.pop

      string.send(type, args.first) do |match|
        diff = { :match => match, :prefix => $`, :suffix => $' }
        diff[:replacement] = match.sub(*args, &block)
        yield(builder, diff)
      end
    end

    private

    attr_reader :builder, :type
  end
end
