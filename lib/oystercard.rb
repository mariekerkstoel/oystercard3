require_relative 'station'
require_relative "journey"
# comment
class Oystercard
  attr_accessor :balance
  attr_reader :entry_station, :exit_station, :journey_list

  LIMIT = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @journey_list = []
  end

  def top_up(amount)
    raise "Balnce limit is £#{LIMIT}, try again" if full?(amount)
    @balance += amount
  end

  def touch_in(station)
    raise 'Not enough funds' if low_funds
    @journey = Journey.new(station)
  end

  def touch_out(station)
    deduct(MIN_FARE)
    @journey.finish_journey(station)
  end

  def in_journey?
    @journey.in_journey?
  end

  private
  def full?(amount)
    @balance + amount > LIMIT
  end

  def deduct(amount)
    @balance -= amount
  end

  def low_funds
    MIN_FARE > @balance
  end
end
