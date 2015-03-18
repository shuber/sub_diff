require File.expand_path('../../../lib/sub_diff/gsub', __FILE__)

RSpec.describe SubDiff::Gsub do
  subject { described_class.new(diffable) }

  let(:diffable) { 'this is a simple test' }

  describe '#diff' do
    context 'with a string' do
      it 'should process arguments correctly' do
        result = subject.diff('i', 'x')
        expect(result.to_s).to eq('thxs xs a sxmple test')
        expect(result.size).to eq(7)
      end

      it 'should handle no matches correctly' do
        result = subject.diff('no-match', 'test')
        expect(result.to_s).to eq(diffable)
        expect(result.size).to eq(1)
      end
    end

    context 'with a regex' do
      it 'should process arguments correctly' do
        result = subject.diff(/(\S*is)/, 'X')
        expect(result.to_s).to eq('X X a simple test')
        expect(result.size).to eq(4)
      end

      it 'should handle captures correctly' do
        result = subject.diff(/(\S*is)/, 'X(\1)')
        expect(result.to_s).to eq('X(this) X(is) a simple test')
        expect(result.size).to eq(4)
      end
    end

    context 'with a hash' do
      it 'should process arguments correctly' do
        result = subject.diff(/(\S*is)/, 'is' => 'IS', 'this' => 'THIS')
        expect(result.to_s).to eq('THIS IS a simple test')
        expect(result.size).to eq(4)
      end
    end

    context 'with a block' do
      it 'should process arguments correctly' do
        result = subject.diff('i') { |match| 'x' }
        expect(result.to_s).to eq('thxs xs a sxmple test')
        expect(result.size).to eq(7)
      end
    end
  end
end
