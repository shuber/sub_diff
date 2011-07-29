module SubDiff
  autoload :Diff,           'sub_diff/diff'
  autoload :DiffCollection, 'sub_diff/diff_collection'
  autoload :Version,        'sub_diff/version'

  def gsub_diff(*args, &block)
    diff_collection = DiffCollection.new
    last_prefix = ''
    gsub(args.first) do |match|
      suffix, prefix, replacement = Diff.new($'), Diff.new($`.sub(last_prefix, '')), Diff.new(match.sub(*args, &block), match)
      diff_collection << prefix << replacement
      diff_collection << suffix unless suffix.send(args.first.is_a?(Regexp) ? :match : :include?, args.first)
      last_prefix = prefix + match
    end
    diff_collection
  end

  def sub_diff(*args, &block)
    diff_collection = DiffCollection.new
    sub(args.first) do |match|
      prefix, suffix, replacement = Diff.new($`), Diff.new($'), Diff.new(match.sub(*args, &block), match)
      diff_collection << prefix << replacement << suffix
    end
    diff_collection
  end
end

String.send(:include, SubDiff)