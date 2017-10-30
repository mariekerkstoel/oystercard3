require 'oystercard'

describe Oystercard do
  let(:card) { described_class.new }
  describe '#balance' do
    it 'should be initialized with a default value of 0' do
      expect(card.balance).to eq(0)
    end
  end
end
