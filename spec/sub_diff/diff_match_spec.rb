require_relative '../../lib/sub_diff/diff_match'

RSpec.describe SubDiff::DiffMatch do
  subject do
    described_class.new(match, replacement, prefix, suffix)
  end

  let(:match)       { 'example' }
  let(:replacement) { 'test' }
  let(:prefix)      { 'prefix' }
  let(:suffix)      { 'suffix' }

  describe '#match' do
    it 'should return the match' do
      expect(subject.match).to eq match
    end
  end

  describe '#prefix' do
    it 'should return the prefix' do
      expect(subject.prefix).to eq prefix
    end
  end

  describe '#replacement' do
    it 'should return the replacement' do
      expect(subject.replacement).to eq replacement
    end
  end

  describe '#suffix' do
    it 'should return the suffix' do
      expect(subject.suffix).to eq suffix
    end
  end
end
