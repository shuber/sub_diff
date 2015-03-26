require 'forwardable'

module SubDiff
  class Differ < Struct.new(:collection, :type)
    extend Forwardable

    def_delegators :collection, :string

    def diff(*args)
      # Ruby 1.8.7 does not support additional args after * (splat)
      block = args.pop

      string.send(type, args.first) do |match|
        diff = { :match => match, :prefix => $`, :suffix => $' }
        diff[:replacement] = match.sub(*args, &block)
        yield(collection, diff)
      end

      collection
    end
  end
end
