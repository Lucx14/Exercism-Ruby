# frozen_string_literal: true

# Grains
module Grains
  def self.square(square)
    raise ArgumentError if square <= 0 || square > 64

    2**(square - 1)
  end

  def self.total
    (1..64)
      .map { |sq| square(sq) }
      .sum
  end
end
