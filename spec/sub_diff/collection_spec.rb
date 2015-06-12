RSpec.describe SubDiff::Collection do
  subject { described_class.new(diffable) }

  let(:diffable) { 'this is a simple test' }

  describe '#changed?' do
    it 'should return true if any diffs have changed' do
      diff = double('diff', changed?: true, empty?: false)
      subject.push(diff)
      expect(subject).to be_changed
    end

    it 'should return false if no diffs have changed' do
      diff = double('diff', changed?: false, empty?: false)
      subject.push(diff)
      expect(subject).not_to be_changed
    end

    it 'should return false if there are no diffs' do
      expect(subject).not_to be_changed
    end
  end

  describe '#clear' do
    before { subject.push('example') }

    let(:block) { proc { subject.clear } }

    it 'should clear diffs' do
      expect(block).to change(subject, :size)
      expect(subject.diffs).to be_empty
    end

    it 'should clear string' do
      expect(block).to change(subject, :to_s)
      expect(subject.to_s).to eq('')
    end

    it 'should return the instance itself' do
      expect(block.call.object_id).to eq(subject.object_id)
    end
  end

  describe '#each' do
    it { is_expected.to be_an(Enumerable) }
    it { is_expected.to delegate(:each).to(:diffs) }
  end

  describe '#push' do
    it 'should append a diff' do
      diff = double('diff', empty?: false)
      block = proc { subject.push(diff) }
      expect(block).to change(subject.diffs, :size)
    end

    it 'should not append an empty diff' do
      diff = double('diff', empty?: true)
      block = proc { subject.push(diff) }
      expect(block).not_to change(subject.diffs, :size)
    end
  end

  describe '#reset' do
    before { subject.push('example') }

    let(:block) { proc { subject.reset } }

    it 'should empty diffs' do
      expect(block).to change(subject, :size)
      expect(subject.diffs).to be_empty
    end

    it 'should reset string' do
      expect(block).to change(subject, :to_s)
      expect(subject.to_s).to eq(diffable)
    end

    it 'should yield if a block is given' do
      local = 'test'
      block = proc { local = 'changed' }
      subject.reset(&block)
      expect(local).to eq('changed')
    end

    it 'should return the instance itself' do
      expect(block.call.object_id).to eq(subject.object_id)
    end
  end

  describe '#size' do
    it { is_expected.to delegate(:size).to(:diffs) }

    it 'should not use the string size' do
      expect(subject.size).not_to eq(subject.to_s.size)
    end
  end

  describe '#__getobj__' do
    it 'should join the diff values if any' do
      subject.push('test')
      subject.push('example')
      expect(subject.__getobj__).to eq('testexample')
    end

    it 'should return the diffable if diffs are empty' do
      expect(subject.__getobj__).to eq(diffable)
    end
  end
end
