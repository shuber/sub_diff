require File.expand_path('../../lib/sub_diff', __FILE__)

RSpec.describe SubDiff do
  subject { 'example' }

  let(:differ) { double 'differ', :diff => 'diffed' }

  it { is_expected.to be_a(described_class) }

  describe '#sub_diff' do
    it 'should delegate to Sub#diff' do
      expect(described_class::Sub).to receive(:new).with(subject).and_return(differ)
      expect(subject.sub_diff).to eq('diffed')
    end
  end

  describe '#gsub_diff' do
    it 'should delegate to Gsub#diff' do
      expect(described_class::Gsub).to receive(:new).with(subject).and_return(differ)
      expect(subject.gsub_diff).to eq('diffed')
    end
  end
end
