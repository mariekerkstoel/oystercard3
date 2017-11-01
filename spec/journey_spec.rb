require_relative '../lib/journey'

describe Journey do
  let(:station) { double :station }
  let(:journey) { described_class.new(station) }

  it 'should be initialized with an entry station' do
    expect(journey.entry_station).to eq (station)
  end
  it 'should be initialized with an exit station' do
    expect(journey.exit_station).to eq nil
  end
end
