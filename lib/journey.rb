class Journey
  attr_reader :entry_station, :exit_station, :journey

  def initialize(station)
    @entry_station = station
    @exit_station = nil
  end

  def finish_journey(station)
    @exit_station = station
    @journey = { entry: @entry_station, exit: @exit_station }
    @entry_station = nil
    puts @journey
  end

  def in_journey?
    true unless entry_station == nil
  end

end
