# frozen_string_literal: true

# Series Exercise
class Series
  def largest_product(length)
    raise ArgumentError if length > digits.length || invalid_digits
    return 1 if length.zero?

    digits
      .chars
      .map(&:to_i)
      .each_cons(length)
      .map { |group| group.inject(:*) }
      .max
  end

  private

  attr_reader :digits

  def initialize(digits)
    @digits = digits
  end

  def invalid_digits
    digits !~ /^[0-9]*$/
  end
end
