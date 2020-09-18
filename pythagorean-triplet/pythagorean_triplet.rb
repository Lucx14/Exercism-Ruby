# frozen_string_literal: true

# Triplet
class Triplet
  attr_reader :a, :b, :c, :sum, :product

  def initialize(a, b, c)
    @a = a
    @b = b
    @c = c
    @sum = a + b + c
    @product = a * b * c
  end

  def pythagorean?
    a**2 + b**2 == c**2
  end

  def self.where(sum: nil, min_factor: 1, max_factor: nil)
    (min_factor..max_factor)
      .to_a
      .combination(3)
      .map { |f| new(*f) }
      .select(&:pythagorean?)
      .select { |triplet| sum ? triplet.sum == sum : triplet }
  end
end
