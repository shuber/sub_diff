require File.expand_path('../../../lib/sub_diff/diff_builder', __FILE__)

RSpec.describe SubDiff::DiffBuilder do
  subject { described_class.new(default) }

  let(:default) { 'example' }

  describe '#collection' do
    it 'should return a DiffCollection containing Diff objects' do
      expect(subject.collection).to be_a(SubDiff::DiffCollection)
      expect(subject.collection.first).to be_a(SubDiff::Diff)
    end

    it 'should return a diff containing the default value if none exist' do
      expect(subject.collection.first.to_s).to eq(default)
      expect(subject.collection.size).to eq(1)
    end

    it 'should not include the default value if diffs exist' do
      subject.push('test')
      expect(subject.collection.first.to_s).to eq('test')
      expect(subject.collection.size).to eq(1)
    end
  end

  describe '#push' do
    it 'should append a new diff to the collection' do
      action = -> { subject.push('test') }
      expect(action).to change(subject, :collection)
      expect(subject.collection.to_a.last.to_s).to eq('test')
    end

    it 'should ignore nil diffs' do
      action = -> { subject.push(nil) }
      expect(action).not_to change(subject, :collection)
    end

    it 'should return the builder instance' do
      result = subject.push('test')
      expect(result).to eq(subject)
    end
  end
end
