require 'oystercard'
describe Oystercard do
  let(:card) { described_class.new }
  let(:station) { double :station }

  describe '#balance' do
    it 'should be initialized with a default value of £0' do
      expect(card.balance).to eq(0)
    end
  end
  describe '#journey_list' do
    it 'should return an empty array' do
      expect(subject.journey_list).to eq []
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
    it 'should never amount to more than £90' do
      card.top_up(40)
      expect { card.top_up(51) }.to raise_error 'Balnce limit is £90, try again'
    end
  end

  context 'Touching in and out' do
    describe '#touch_in' do
      it 'Should return in-journey if touched in ' do
        subject.top_up(5)
        subject.touch_in(station)
        expect(subject.in_journey?).to eq true
      end
      it 'Should raise error if touch in with low funds' do
        expect { subject.touch_in(station) }.to raise_error 'Not enough funds'
      end
      it "should tell me which entry station I'm touching in" do
        subject.top_up(60)
        subject.touch_in(station)
        expect(subject.entry_station).to eq(station)
      end
    end
    describe '#touch_out' do
      before { subject.top_up(5) }
      before { subject.touch_in(station) }

      it 'should return not in journey if touched out' do
        subject.touch_out(station)
        expect(subject.in_journey?).to eq false
      end
      it 'Should change entry_station to nil when touched out' do
        subject.touch_out(station)
        expect(subject.entry_station).to eq(nil)
      end
      it "should tell me which exit station I'm touching out" do
        subject.touch_out(station)
        expect(subject.exit_station).to eq(station)
      end
      it 'should return an array of journeys' do
        subject.touch_out(station)
        expect(subject.journey_list[-1]).to eq({station => station})
      end
      it 'should deduct fare from balance' do
        expect { card.touch_out(station) }.to change { card.balance }.by(-Oystercard::MIN_FARE)
      end
    end
  end
end
