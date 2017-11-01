require_relative '../lib/journey'

describe Journey do
  let(:station) { double :station }
  let(:journey) { described_class.new }
  before {journey.start(station)}

  describe "#initialize" do
    it 'should be initialized with an entry station' do
      expect(journey.entry_station).to eq (station)
    end
    it 'should be initialized with an exit station' do
      expect(journey.exit_station).to eq nil
    end
  end

  describe "#finish_journey" do
    it "sets your exit station to the station you pass it as argument" do
      journey.finish_journey(station)
      expect(journey.exit_station).to eq(station)
    end
    it "expects journey.journey to return a hash of one journey" do
      journey.finish_journey(station)
      expect(journey.journey).to eq( {entry: station, exit: station} )
    end
    it "expects finish journey to reset entry_station to nil" do
      journey.finish_journey(station)
      expect(journey.entry_station).to eq nil
    end
  end


  describe "#in_journey?" do
    it "expects in_journey to be false after finish_journey" do
      journey.finish_journey(station)
      expect(journey).to_not be_in_journey
    end

    it "expects in_journey to be true when entry station is not nil" do
      expect(journey).to be_in_journey
    end
  end

  describe "#fare" do
    it 'should deduct penalty fare when forgot to touch out' do
      
    end
  end

end
