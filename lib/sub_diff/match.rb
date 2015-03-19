class Match < Struct.new(:match, :prefix, :suffix, :replacement)
  alias_method :to_str, :match
end
