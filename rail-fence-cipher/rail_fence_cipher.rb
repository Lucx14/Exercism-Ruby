# frozen_string_literal: true

# Rail fence cipher
module RailFenceCipher
  def self.encode(plain_text, rails)
    navigate(rails, plain_text.length)
      .zip(plain_text.chars)
      .sort
      .map { |data| data[1] }
      .join
  end

  def self.decode(encoded_text, rails)
    navigate(rails, encoded_text.length)
      .sort
      .zip(encoded_text.chars)
      .sort_by { |data| data[0][1] }
      .map { |data| data[1] }
      .join
  end

  def self.navigate(rails, length)
    pattern = (0..rails - 1).to_a + (1..rails - 2).to_a.reverse
    pattern.cycle.first(length).zip(0..length)
  end
end
