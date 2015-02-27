require_relative '../../lib/sub_diff/diff'

RSpec.describe SubDiff::Diff do
  let(:diff)                   { described_class.new(value, value_was) }
  let(:diff_without_value_was) { described_class.new(value) }
  let(:diff_with_empty_values) { described_class.new('', '') }

  let(:value)     { 'test' }
  let(:value_was) { 'testing' }

  describe '#initialize' do
    it 'should accept value_was' do
      expect(diff.value_was).to eq value_was
    end

    it 'should set value_was to value if it is not specified' do
      expect(diff_without_value_was.value_was).to eq value
    end
  end

  describe '#changed?' do
    it 'should return true if value does not match value_was' do
      expect(diff).to be_changed
    end

    it 'should return false if value matches value_was' do
      expect(diff_without_value_was).not_to be_changed
      expect(diff_with_empty_values).not_to be_changed
    end
  end

  describe '#enumerable?' do
    it 'should return true if the diff was changed' do
      expect(diff).to be_enumerable
    end

    it 'should return true if the diff value is not empty' do
      expect(diff).to receive(:changed?).and_return false
      expect(diff).to be_enumerable
    end

    it 'should return false if the diff was not changed and is empty' do
      expect(diff_with_empty_values).not_to be_enumerable
    end
  end

  describe '#to_s' do
    it 'should return the diff value' do
      expect(diff.to_s).to eq value
    end
  end

  describe '#value' do
    it 'should return the diff value' do
      expect(diff.value).to eq value
    end
  end
end
