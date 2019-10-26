class Sieve
  attr_reader :number, :range

  def initialize(number)
    @number = number
    @range = (2..number).to_a
  end

  def primes
    multiples = []
    range.each{ |num| multiples << find_multiples(num) }
    composite_numbers = multiples.flatten.uniq
    range.reject{ |num| composite_numbers.include?(num) }
  end

  private

  def find_multiples(num)
    result = [ num * 2 ]
    i = 2
    while result.last <= number do
      i += 1
      result << num * i 
    end
    result.pop if result.last > number
    result
  end
end
