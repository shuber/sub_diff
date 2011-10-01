require File.expand_path('../test_helper', __FILE__)

module SubDiff
  class DiffCollectionTest < Test::Unit::TestCase
    def setup
      @diffs = [Diff.new('one '), Diff.new('two', '2'), Diff.new(' three ')]
      @diff_collection = DiffCollection.new(@diffs)
    end

    def test_append
      size, value = @diff_collection.size, @diff_collection.to_s
      @diff_collection << Diff.new('four', '4')
      @diff_collection << Diff.new('', 'test')
      @diff_collection << Diff.new('') # should skip this since it's empty
      assert_equal size + 2, @diff_collection.size
      assert_not_equal value, @diff_collection.to_s
    end

    def test_enumerable
      assert @diff_collection.is_a?(Enumerable)
      assert_equal @diffs, @diff_collection.collect { |diff| diff }
    end

    def test_method_missing
      assert_equal @diffs.join.upcase, @diff_collection.upcase
      assert_raises(NoMethodError) { @diff_collection.invalid_method }
    end

    def test_respond_to_missing?
      assert @diff_collection.respond_to?(:upcase)
      assert !@diff_collection.respond_to?(:invalid_method)
    end

    def test_size
      assert_equal @diffs.size, @diff_collection.size
    end

    def to_s
      assert_equal @diffs.join, @diff_collection.to_s
    end
  end
end