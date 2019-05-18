class Squares

  attr_reader :n
  
  def initialize(n)
    @n = (1..n).to_a
  end

  def square_of_sum
    n.sum ** 2
  end

  def sum_of_squares
    n.map { |n| n ** 2 }.sum
  end

  def difference
    square_of_sum - sum_of_squares
  end

end