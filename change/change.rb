# frozen_string_literal: true

# Change
class Change
  class ImpossibleCombinationError < StandardError; end
  class NegativeTargetError < StandardError; end

  def self.generate(coins, value)
    raise NegativeTargetError if value.negative?
    return [] if value.zero?

    max_size_of_result = value / coins.min

    (1..max_size_of_result)
      .each do |size|
        result = coins.repeated_combination(size).find { |group| group.sum == value }
        return result if result
      end
    raise ImpossibleCombinationError
  end
end
