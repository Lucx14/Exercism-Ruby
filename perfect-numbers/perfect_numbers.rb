# frozen_string_literal: true

# Perfect Numbers
module PerfectNumber
  def self.classify(num)
    raise RuntimeError unless num.positive?

    aliquot = (1...num).select { |n| n if (num % n).zero? }.sum

    if aliquot == num
      'perfect'
    elsif aliquot > num
      'abundant'
    else
      'deficient'
    end
  end
end
