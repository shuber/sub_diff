require 'sub_diff/sub'

module SubDiff
  class Gsub < Sub
    private

    def diff!(_builder, match, _search)
      super
      last_prefix << prefix(match) << match[:match]
    end

    def last_prefix
      @last_prefix ||= ''
    end

    def prefix(_match)
      super.sub(last_prefix, '')
    end

    def suffix(_match, search)
      matcher = suffix_matcher(search)
      super unless super.send(matcher, search)
    end

    def suffix_matcher(search)
      search.is_a?(Regexp) ? :match : :include?
    end
  end
end
