require_relative '../../lib/sub_diff/differ'

RSpec.describe SubDiff::Differ do
  subject { described_class.new diffable }

  let(:diffable) { 'example' }

  it { is_expected.to be_respond_to(:diffable) }
  it { is_expected.to be_respond_to(:collection) }

  describe '#diff' do
    it 'should return a DiffCollection' do
      expect(subject.diff).to be_a SubDiff::DiffCollection
      expect(subject.diff.first).to be_a SubDiff::Diff
      expect(subject.diff.size).to eq 1
    end

    it 'should have at least one Diff' do
      expect(subject.diff.size).to eq 1
      expect(subject.diff.first).to be_a SubDiff::Diff
    end

    it 'should call diff! with specified args' do
      args = double "args"
      expect(subject).to receive(:diff!).with(args)
      subject.diff(args)
    end
  end
end
