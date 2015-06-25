module SubDiff
  # Processes matches for {String#gsub} replacements
  # by pushing diffs into a {Builder} instance.
  #
  # Used internally by {Factory}.
  #
  # @api private
  class Gsub < Sub
    private

    def append_diff_to_builder(diff, _search)
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
      regex = Regexp.new(search)
      suffix unless suffix.match(regex)
    end
  end
end
