require_relative 'sub'

module SubDiff
  class Gsub < Sub
    def initialize(diffable)
      super
      @last_prefix = nil
    end

    protected

    attr_reader :last_prefix

    def diff_method
      :gsub
    end

    def prefix
      super.sub(last_prefix, '')
    end

    def suffix
      unless super.send(matcher, args.first)
        super
      end
    end

    private

    def diff!
      instance_variable_replace(last_prefix: '') { super }
    end

    def process
      super
      last_prefix << prefix << match
    end

    def matcher
      if args.first.is_a?(Regexp)
        :match
      else
        :include?
      end
    end
  end
end
