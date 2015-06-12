RSpec.describe SubDiff do
  subject { 'this is a simple test' }

  describe '#sub_diff' do
    context 'when called multiple times with the same arguments' do
      it 'should return a new object' do
        first = subject.sub_diff('simple', 'very simple')
        second = subject.sub_diff('simple', 'very simple')
        expect(second.object_id).not_to eq(first.object_id)
      end
    end

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

    context 'with a hash' do
      it 'should process arguments correctly' do
        result = subject.sub_diff(/simple/, 'simple' => 'harder')
        expect(result.to_s).to eq('this is a harder test')
        expect(result.size).to eq(3)
      end
    end
  end

  describe '#gsub_diff' do
    context 'when called multiple times with the same arguments' do
      it 'should return a new object' do
        first = subject.gsub_diff('i', 'x')
        second = subject.gsub_diff('x', 'x')
        expect(second.object_id).not_to eq(first.object_id)
      end
    end

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

    context 'with a hash' do
      it 'should process arguments correctly' do
        result = subject.gsub_diff(/(\S*is)/, 'is' => 'IS', 'this' => 'THIS')
        expect(result.to_s).to eq('THIS IS a simple test')
        expect(result.size).to eq(4)
      end
    end
  end
end
