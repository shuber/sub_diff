require File.expand_path('../../lib/sub_diff', __FILE__)

RSpec.describe SubDiff do
  subject { 'this is a simple test' }

  describe '#sub_diff' do
    context 'with a string' do
      it 'should process arguments correctly' do
        result = subject.sub_diff('simple', 'very simple')
        expect(result.to_s).to eq('this is a very simple test')
        expect(result.size).to eq(3)
      end

      it 'should handle no matches correctly' do
        result = subject.sub_diff('no-match', 'test')
        expect(result.to_s).to eq(subject)
        expect(result.size).to eq(0)
      end
    end

    context 'with a regex' do
      it 'should process arguments correctly' do
        result = subject.sub_diff(/a \S+/, 'an easy')
        expect(result.to_s).to eq('this is an easy test')
        expect(result.size).to eq(3)
      end

      it 'should handle captures correctly' do
        result = subject.sub_diff(/a (\S+)/, 'a very \1')
        expect(result.to_s).to eq('this is a very simple test')
        expect(result.size).to eq(3)
      end
    end

    context 'with a block' do
      it 'should process arguments correctly' do
        result = subject.sub_diff('simple') { |match| 'block' }
        expect(result.to_s).to eq('this is a block test')
        expect(result.size).to eq(3)
      end
    end

    if RUBY_VERSION > '1.8.7'
      context 'with a hash' do
        it 'should process arguments correctly' do
          result = subject.sub_diff(/simple/, 'simple' => 'harder')
          expect(result.to_s).to eq('this is a harder test')
          expect(result.size).to eq(3)
        end
      end
    end
  end

  describe '#gsub_diff' do
    context 'with a string' do
      it 'should process arguments correctly' do
        result = subject.gsub_diff('i', 'x')
        expect(result.to_s).to eq('thxs xs a sxmple test')
        expect(result.size).to eq(7)
      end

      it 'should handle no matches correctly' do
        result = subject.gsub_diff('no-match', 'test')
        expect(result.to_s).to eq(subject)
        expect(result.size).to eq(0)
      end
    end

    context 'with a regex' do
      it 'should process arguments correctly' do
        result = subject.gsub_diff(/(\S*is)/, 'X')
        expect(result.to_s).to eq('X X a simple test')
        expect(result.size).to eq(4)
      end

      it 'should handle captures correctly' do
        result = subject.gsub_diff(/(\S*is)/, 'X(\1)')
        expect(result.to_s).to eq('X(this) X(is) a simple test')
        expect(result.size).to eq(4)
      end
    end

    context 'with a block' do
      it 'should process arguments correctly' do
        result = subject.gsub_diff('i') { |match| 'x' }
        expect(result.to_s).to eq('thxs xs a sxmple test')
        expect(result.size).to eq(7)
      end
    end

    if RUBY_VERSION > '1.8.7'
      context 'with a hash' do
        it 'should process arguments correctly' do
          result = subject.gsub_diff(/(\S*is)/, 'is' => 'IS', 'this' => 'THIS')
          expect(result.to_s).to eq('THIS IS a simple test')
          expect(result.size).to eq(4)
        end
      end
    end
  end
end
