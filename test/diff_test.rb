require File.expand_path('../test_helper', __FILE__)

class DiffTest < Test::Unit::TestCase

  def setup
    @diff_value = 'test'
    @diff_value_was = 'testing'
    @diff = SubDiff::Diff.new(@diff_value, @diff_value_was)
    @diff_without_value_was = SubDiff::Diff.new(@diff_value)
  end

  def test_initialize_with_value_was
    assert_equal @diff_value, @diff.value
    assert_equal @diff_value_was, @diff.value_was
  end

  def test_initialize_without_value_was
    assert_equal @diff_value, @diff_without_value_was.value
    assert_equal @diff_without_value_was.value, @diff_without_value_was.value_was
  end

  def test_changed
    assert @diff.changed?
    assert !@diff_without_value_was.changed?
    assert !SubDiff::Diff.new('test', 'test').changed?
  end

  def test_method_missing
    assert_equal @diff_value.upcase, @diff.upcase
    assert_raises(NoMethodError) { @diff.invalid_method }
  end

  def test_to_s
    assert_equal @diff.value, @diff.to_s
  end

end