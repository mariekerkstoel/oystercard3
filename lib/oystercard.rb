# Something
class Oystercard
  attr_accessor :balance
  attr_reader :in_journey
  LIMIT = 90
  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "Balnce limit is £#{LIMIT}, try again" if @balance + amount > LIMIT
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end
end
