require_relative 'station'
# comment
class Oystercard
  attr_accessor :balance
  attr_reader :in_journey, :entry_station

  LIMIT = 90
  MIN_FUND = 1

  def initialize
    @balance = 0
    @in_journey = false
    @entry_station = nil
  end

  def top_up(amount)
    raise "Balnce limit is £#{LIMIT}, try again" if @balance + amount > LIMIT
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in(station = Station.new('Liverpool Street', 1))
    raise 'Not enough funds' if low_funds
    @entry_station = station
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  private

  def low_funds
    MIN_FUND > @balance
  end
end
