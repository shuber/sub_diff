require File.expand_path('../../../lib/sub_diff/diff_collection', __FILE__)

RSpec.describe SubDiff::DiffCollection do
  subject { described_class.new(diffs_with_empty) }

  let(:diffs_with_empty) do
    diffs.dup << diff('')
  end

  let(:diffs) do
    [diff('one '), diff('two'), diff(' three ')]
  end

  def diff(value)
    double 'diff', :changed? => false,
                   :empty? => value.empty?,
                   :to_s => value,
                   :to_str => value
  end

  describe '#changed?' do
    it 'should return true if any diffs have changed' do
      expect(diffs.first).to receive(:changed?).and_return(true)
      expect(subject).to be_changed
    end

    it 'should return false if no diffs have changed' do
      expect(subject).not_to be_changed
    end
  end

  describe '#diffs' do
    it 'should exclude empty diffs' do
      expect(subject.diffs).to eq(diffs)
    end
  end

  describe '#each' do
    it { is_expected.to be_an(Enumerable) }
    it { is_expected.to delegate(:each).to(:diffs) }
  end

  describe '#size' do
    it { is_expected.to delegate(:size).to(:diffs) }

    it 'should not use the string size' do
      expect(subject.size).not_to eq(subject.to_s.size)
    end
  end

  describe '#to_s' do
    it 'should join the diff values' do
      expect(subject.to_s).to eq('one two three ')
    end
  end
end
