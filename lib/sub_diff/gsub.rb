require 'sub_diff/sub'

module SubDiff
  class Gsub < Sub
    private

    def diff_method
      :gsub
    end

    def process(_builder, match, _search)
      super
      last_prefix << prefix(match) << match
    end

    def last_prefix
      @last_prefix ||= ''
    end

    def prefix(_match)
      super.sub(last_prefix, '')
    end

    def suffix(_match, search)
      matcher = suffix_matcher(search)

      unless super.send(matcher, search)
        super
      end
    end

    def suffix_matcher(search)
      if search.is_a?(Regexp)
        :match
      else
        :include?
      end
    end
  end
end
