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
    raise "Balance limit is £#{LIMIT},try again" if full?(amount)
    @balance += amount
  end

  def touch_in(station)
    raise 'Not enough funds' if low_funds
    @journey = Journey.new(station)
    update_list
  end

  def touch_out(station)
    deduct(MIN_FARE)
    if @journey_list.empty? || @journey.entry_station == nil
      add_empty_entry(station)
    else
      @journey.finish_journey(station)
      complete_journey
    end
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

  def update_list
    @journey_list << @journey.journey
  end

  def add_empty_entry(station)
    @journey_list << { entry: nil , exit: station }
  end

  def complete_journey
    @journey_list.last[:exit] = @journey.exit_station
  end

  def low_funds
    MIN_FARE > @balance
  end
end
