# Something
class Oystercard
  attr_accessor :balance
  LIMIT = 90
  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise 'Balnce limit is £90, try again' if @balance + amount > LIMIT
    @balance += amount
  end
end
