require_relative 'station'
require_relative 'journey'
# comment
class Oystercard
  attr_accessor
  attr_reader :journey_list, :balance

  LIMIT = 90
  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @balance = 0
    @journey = Journey.new
    @journey_list = [entry: nil, exit: nil]
  end

  def top_up(amount)
    raise "Balance limit is £#{LIMIT},try again" if full?(amount)
    @balance += amount
  end

  def touch_in(station)
    offenses
    @journey.start(station)
    update_list
  end

  def touch_out(station)
    finishing_journey(station)
    deduct(fare_touch_out)
    deduct(MIN_FARE) if fare_touch_out == 0
  end

  def in_journey?
    @journey.in_journey?
  end


  private

  def fare_touch_in
    if @journey_list.length == 1
      0
    elsif @journey_list.last[:exit] == nil && @journey_list.last[:entry] != nil
      PENALTY_FARE
    else
      0
    end
  end

  def fare_touch_out
    if @journey_list.last[:exit] != nil && @journey_list.last[:entry] == nil
      PENALTY_FARE
    else
      0
    end
  end

  def offenses
    raise 'Not enough funds' if low_funds
    deduct(fare_touch_in)
  end

  def finishing_journey(station)
    if @journey_list.empty? || @journey.entry_station == nil
      add_empty_entry(station)
    else
      @journey.finish_journey(station)
      complete_journey
    end
  end

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
