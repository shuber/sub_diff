module SubDiff
  class Sub
    def initialize(string)
      @string = string
    end

    def diff(*args, &block)
      diff_collection do |collection|
        string.sub(args.first) do |match|
          suffix, prefix, replacement = Diff.new($'), Diff.new($`), Diff.new(match.sub(*args, &block), match)
          collection << prefix << replacement << suffix
        end
      end
    end

    private

    attr_reader :string

    def diff_collection(&block)
      DiffCollection.new(&block).tap do |collection|
        if collection.empty?
          collection << Diff.new(string)
        end
      end
    end
  end
end
