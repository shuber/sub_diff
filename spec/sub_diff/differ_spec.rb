require_relative '../../lib/sub_diff/differ'

RSpec.describe SubDiff::Differ do
  subject { described_class.new(diffable) }

  let(:diffable) { 'example' }

  describe '#diff' do
    it 'should return a DiffCollection containing Diff objects' do
      expect(subject.diff).to be_a SubDiff::DiffCollection
      expect(subject.diff.first).to be_a SubDiff::Diff
    end

    it 'should call diff! with specified args' do
      args = double("args")
      expect(subject).to receive(:diff!).with(args)
      subject.diff(args)
    end
  end
end
