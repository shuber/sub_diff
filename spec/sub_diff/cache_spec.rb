require_relative '../../lib/sub_diff/cache'

RSpec.describe SubDiff::Cache do
  subject { mock.new }

  let(:mock) do
    Class.new.instance_exec(described_class) do |mod|
      include mod

      attr_reader :existing, :created

      def initialize
        @existing = :existing
      end

      self
    end
  end

  describe '#cache' do
    it 'should set and restore new instance variables' do
      subject.cache(created: :created) do
        expect(subject.created).to eq :created
      end

      expect(subject.created).to be_nil
    end

    it 'should overwrite and restore existing instance variables' do
      subject.cache(existing: :altered) do
        expect(subject.existing).to eq :altered
      end

      expect(subject.existing).to be_nil
    end

    it 'should return the last statement' do
      expected = subject.cache(created: :created) { :expected }
      expect(expected).to eq :expected
    end
  end
end
