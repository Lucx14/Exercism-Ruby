module PrimeFactors
  def self.of(num)
    result = []
    divisor = 2

    while num > 1
      data = num.divmod(divisor)
      if (data[1]).zero?
        num = data[0]
        result << divisor
      else
        divisor += 1
      end
    end

    result
  end
end
