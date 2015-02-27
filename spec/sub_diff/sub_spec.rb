require_relative '../../lib/sub_diff/sub'

RSpec.describe SubDiff::Sub do
  subject { described_class.new diffable }

  let(:diffable) { 'this is a simple test' }

  describe '#diff' do
    context 'with a string' do
      it 'should process arguments correctly' do
        result = subject.diff('simple', 'very simple')
        expect(result.to_s).to eq 'this is a very simple test'
        expect(result.size).to eq 3
      end

      it 'should handle no matches correctly' do
        result = subject.diff('no-match', 'test')
        expect(result.to_s).to eq diffable
        expect(result.size).to eq 1
      end
    end

    context 'with a regex' do
      it 'should process arguments correctly' do
        result = subject.diff(/a \S+/, 'an easy')
        expect(result.to_s).to eq 'this is an easy test'
        expect(result.size).to eq 3
      end

      it 'should handle captures correctly' do
        result = subject.diff(/a (\S+)/, 'a very \1')
        expect(result.to_s).to eq 'this is a very simple test'
        expect(result.size).to eq 3
      end
    end

    context 'with a hash' do
      it 'should process arguments correctly' do
        result = subject.diff(/simple/, 'simple' => 'harder')
        expect(result.to_s).to eq 'this is a harder test'
        expect(result.size).to eq 3
      end
    end

    context 'with a block' do
      it 'should process arguments correctly' do
        result = subject.diff('simple') { |match| 'block' }
        expect(result.to_s).to eq 'this is a block test'
        expect(result.size).to eq 3
      end
    end
  end
end
