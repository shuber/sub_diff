require File.expand_path('../test_helper', __FILE__)

module SubDiff
  class DiffCollectionTest < Test::Unit::TestCase
    def setup
      @diffs = [
        Diff.new('one '),
        Diff.new('two', '2'),
        Diff.new(' three ')
      ]

      @diff_collection = DiffCollection.new(@diffs)
    end

    def test_append
      size, value = @diff_collection.size, @diff_collection.to_s

      @diff_collection << Diff.new('four', '4')
      @diff_collection << Diff.new('', 'test')

      # This one should be skipped since it's empty
      @diff_collection << Diff.new('')

      assert_equal size + 2, @diff_collection.size
      assert_not_equal value, @diff_collection.to_s
    end

    def test_enumerable
      assert @diff_collection.is_a?(Enumerable)
      assert_equal @diffs, @diff_collection.collect { |diff| diff }
    end

    def to_s
      assert_equal @diffs.join, @diff_collection.to_s
    end

    def test_size
      assert_equal @diffs.size, @diff_collection.size
    end
  end
end
