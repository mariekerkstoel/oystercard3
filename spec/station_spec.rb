require './lib/station'

describe Station do

  subject { described_class.new('Liverpool', 1)}
  it 'should have an station' do
    expect(subject.name).to eq('Liverpool')
  end
  it 'should have a zone' do
    expect(subject.zone).to eq(1)
  end
end
