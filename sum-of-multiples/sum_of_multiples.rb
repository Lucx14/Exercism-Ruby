class SumOfMultiples

  attr_reader :divisors

  def initialize(*divisors)
    @divisors = divisors
  end

  def to(n)
    multiples = []
    numbers = build_array(n)
    numbers.each do |num|
      divisors.each { |divisor| multiples << num if num % divisor == 0 }
    end

    multiples.uniq.sum
  end

  private

  def build_array(max_number_plus_one)
    n = max_number_plus_one - 1
    max_number_plus_one > 1 ? (1..n).to_a : []
  end

end