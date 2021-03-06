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
      expect(subject.journey_list).to eq [{entry: nil, exit: nil}]
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
      expect { card.top_up(51) }.to raise_error 'Balance limit is £90,try again'
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
      it "should tell me that entry station is nil in journey list" do
        subject.top_up(60)
        subject.touch_in(station)
        expect(subject.journey_list.last[:entry]).to eq(station)
      end
      it "should tell me that exit station is nil in journey list" do
        subject.top_up(60)
        subject.touch_in(station)
        expect(subject.journey_list.last[:exit]).to eq(nil)
      end
    end
    describe '#fare_touch_in' do
      it "should give a penalty if didn't touch out" do
        card.top_up(60)
        card.touch_in(station)
        card.touch_in(station)
        expect(card.balance).to eq 54
      end
    end
    describe '#fare_touch_out' do
      it "should give a penalty if didn't touch in" do
        card.top_up(30)
        # card.touch_out(station)
        card.touch_out(station)
        expect(card.balance).to eq 24
      end
    end
    describe '#touch_out' do
      before { subject.top_up(5) }
      before { subject.touch_in(station) }

      it 'should return not in journey if touched out' do
        subject.touch_out(station)
        expect(subject.in_journey?).to eq false
      end
      it 'should return an array of journeys' do
        subject.touch_out(station)
        expect(subject.journey_list.last).to eq({entry: station, exit: station})
      end
      it 'should deduct fare from balance' do
        card.top_up(6)
        card.touch_in(station)
        expect { card.touch_out(station) }.to change { card.balance }.by(-Oystercard::MIN_FARE)
      end
    end
  end
end
