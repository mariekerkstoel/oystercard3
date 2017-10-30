require 'oystercard'

describe Oystercard do
  let(:card) { described_class.new }
  describe '#balance' do
    it 'should be initialized with a default value of 0' do
      expect(card.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it 'should add the designated sum to the balance' do
      card.top_up(5)
      expect(card.balance).to eq(5)
    end

    it 'should add the designated sum to the balance' do
      card.top_up(5)
      card.top_up(5)
      expect(card.balance).to eq(10)
    end
  end
end
