require_relative '../../lib/sub_diff/diff_collection'

RSpec.describe SubDiff::DiffCollection do
  before { diffs.each(&subject.method(:<<)) }

  subject { described_class.new }

  let(:diffs) do
    [
      SubDiff::Diff.new('one '),
      SubDiff::Diff.new('two', '2'),
      SubDiff::Diff.new(' three ')
    ]
  end

  it { is_expected.to be_an Enumerable }
  it { is_expected.to delegate(:each).to(:diffs) }
  it { is_expected.to delegate(:size).to(:diffs) }

  describe '#<<' do
    it 'should skip empty diffs' do
      size, value = subject.size, subject.to_s

      subject << SubDiff::Diff.new('four', '4')
      subject << SubDiff::Diff.new('', 'test')

      # This one should be skipped since it's empty
      subject << SubDiff::Diff.new('')

      expect(subject.size).to eq(size + 2)
      expect(subject.to_s).not_to eq value
    end
  end

  describe '#to_s' do
    it 'should join the diff values' do
      expect(subject.to_s).to eq 'one two three '
    end
  end
end
