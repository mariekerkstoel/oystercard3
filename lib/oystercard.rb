require_relative 'station'
# comment
class Oystercard
  attr_accessor :balance
  attr_reader :entry_station, :exit_station, :journey_list

  LIMIT = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journey_list = []
  end

  def top_up(amount)
    raise "Balnce limit is £#{LIMIT}, try again" if full?(amount)
    @balance += amount
  end

  def touch_in(station)
    raise 'Not enough funds' if low_funds
    @entry_station = station
  end

  def touch_out(station)
    @exit_station = station
    store_journey
    @entry_station = nil
    deduct(MIN_FARE)
  end

  def in_journey?
    @entry_station != nil
  end

  private
  def full?(amount)
    @balance + amount > LIMIT
  end

  def store_journey
    @journey_list << {@entry_station => @exit_station}
  end

  def deduct(amount)
    @balance -= amount
  end

  def low_funds
    MIN_FARE > @balance
  end
end
