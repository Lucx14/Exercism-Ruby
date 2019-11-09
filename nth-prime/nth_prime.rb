module Prime
  def self.nth(number)
    raise ArgumentError, 'must be greater than 0' if number < 1  

    primes = []
    start = 2

    while primes.length < number do
      primes << start if is_prime?(start)
      start += 1
    end

    primes.last
  end

  private
 
  def self.is_prime?(num)
    return if num <= 1
    (2..Math.sqrt(num)).none? { |i| (num % i).zero? }
  end
end

