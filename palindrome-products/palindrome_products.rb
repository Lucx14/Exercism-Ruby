# frozen_string_literal: true

# Palindrome Products
class Palindromes
  Palindrome = Struct.new(:value, :factors)

  attr_reader :max_factor, :min_factor, :palindromes

  def initialize(max_factor:, min_factor: 1)
    @max_factor = max_factor
    @min_factor = min_factor
    @palindromes ||= Hash.new { |hash, key| hash[key] = [] }
  end

  def generate
    pairs.each do |pair|
      product = pair.reduce(:*)
      palindromes[product] << pair if palindrome?(product)
    end
  end

  def largest
    Palindrome.new(*palindromes.max)
  end

  def smallest
    Palindrome.new(*palindromes.min)
  end

  private

  def pairs
    (min_factor..max_factor).to_a.repeated_combination(2).lazy
  end

  def palindrome?(num)
    num.to_s.reverse == num.to_s
  end
end
