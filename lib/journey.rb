require_relative 'oystercard'

class Journey
  attr_reader :entry_station, :exit_station, :journey

  def start(station)
    @entry_station = station
    @exit_station = nil
    @journey = { entry: @entry_station, exit: @exit_station }
  end

  def finish_journey(station)
    @exit_station = station
    @journey = { entry: @entry_station, exit: @exit_station }
    @entry_station = nil
    puts @journey
  end

  def in_journey?
    !!@entry_station
  end
end
