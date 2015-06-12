module SubDiff
  class Gsub < Sub
    private

    def process(_builder, diff, _search)
      super
      last_prefix << prefix(diff) << diff[:match]
    end

    def last_prefix
      @last_prefix ||= ''
    end

    def prefix(_diff)
      super.sub(last_prefix, '')
    end

    def suffix(_diff, search)
      suffix = super
      matcher = suffix_matcher(search)
      skip_suffix = suffix.send(matcher, search)
      suffix unless skip_suffix
    end

    def suffix_matcher(search)
      search.is_a?(Regexp) ? :match : :include?
    end
  end
end
