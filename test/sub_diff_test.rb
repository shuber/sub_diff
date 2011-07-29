require File.expand_path('../test_helper', __FILE__)

module SubDiff
  class SubDiffTest < Test::Unit::TestCase
    def setup
      @string = 'this is a simple test'
    end

    def test_gsub_diff_with_block
      diff_collection = @string.gsub_diff('i') { |match| 'x' }
      assert_equal 'thxs xs a sxmple test', diff_collection.to_s
      assert_equal 7, diff_collection.size
    end

    def test_gsub_diff_with_hash
      diff_collection = @string.gsub_diff(/(\S*is)/, 'is' => 'IS', 'this' => 'THIS')
      assert_equal 'THIS IS a harder test', diff_collection.to_s
      assert_equal 4, diff_collection.size
    rescue TypeError => error # Hash arguments only work in ruby 1.9+
      assert_equal "can't convert Hash into String", error.message
    end

    def test_gsub_diff_with_regex
      diff_collection = @string.gsub_diff(/(\S*is)/, 'X')
      assert_equal 'X X a simple test', diff_collection.to_s
      assert_equal 4, diff_collection.size
    end

    def test_gsub_diff_with_regex_captures
      diff_collection = @string.gsub_diff(/(\S*is)/, 'X(\1)')
      assert_equal 'X(this) X(is) a simple test', diff_collection.to_s
      assert_equal 4, diff_collection.size
    end

    def test_gsub_diff_with_string
      diff_collection = @string.gsub_diff('i', 'x')
      assert_equal 'thxs xs a sxmple test', diff_collection.to_s
      assert_equal 7, diff_collection.size
    end

    def test_gsub_diff_without_matches
      diff_collection = @string.gsub_diff('no-match', 'test')
      assert_equal @string, diff_collection.to_s
      assert_equal 1, diff_collection.size
    end

    def test_sub_diff_with_block
      diff_collection = @string.sub_diff('simple') { |match| 'block' }
      assert_equal 'this is a block test', diff_collection.to_s
      assert_equal 3, diff_collection.size
    end

    def test_sub_diff_with_hash
      diff_collection = @string.sub_diff(/simple/, 'simple' => 'harder')
      assert_equal 'this is a harder test', diff_collection.to_s
      assert_equal 3, diff_collection.size
    rescue TypeError => error # Hash arguments only work in ruby 1.9+
      assert_equal "can't convert Hash into String", error.message
    end

    def test_sub_diff_with_regex
      diff_collection = @string.sub_diff(/a \S+/, 'an easy')
      assert_equal 'this is an easy test', diff_collection.to_s
      assert_equal 3, diff_collection.size
    end

    def test_sub_diff_with_regex_captures
      diff_collection = @string.sub_diff(/a (\S+)/, 'a very \1')
      assert_equal 'this is a very simple test', diff_collection.to_s
      assert_equal 3, diff_collection.size
    end

    def test_sub_diff_with_string
      diff_collection = @string.sub_diff('simple', 'very simple')
      assert_equal 'this is a very simple test', diff_collection.to_s
      assert_equal 3, diff_collection.size
    end

    def test_sub_diff_without_matches
      diff_collection = @string.sub_diff('no-match', 'test')
      assert_equal @string, diff_collection.to_s
      assert_equal 1, diff_collection.size
    end
  end
end