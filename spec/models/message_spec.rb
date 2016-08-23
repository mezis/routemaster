require 'spec_helper'
require 'routemaster/models/message'

describe Routemaster::Models::Message do
  let(:options) { {} }

  subject { described_class.new(options) }

  describe '#uid' do
    it 'is generated' do
      expect(subject.uid).to match /^\h{8}-\h{4}-\h{4}-\h{4}-\h{12}$/
    end

    context 'when specified' do
      let(:options) {{ uid: 'abcd-1234' }}

      it 'is honoured' do
        expect(subject.uid).to eq('abcd-1234')
      end
    end
  end

  describe '#timestamp' do
    it 'is generated' do
      expect(subject.timestamp).to be_within(50).of(Routemaster.now)
    end

    context 'when specified' do
      let(:options) {{ timestamp: 1234 }}

      it 'is honoured' do
        expect(subject.timestamp).to eq(1234)
      end
    end
  end
end
