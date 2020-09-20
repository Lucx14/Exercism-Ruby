# frozen_string_literal: true

# Diamond
module Diamond
  ALPHABET = ('A'..'Z').to_a.join

  def self.make_diamond(input)
    raise ArgumentError unless ALPHABET.include?(input)

    upper = ('A'..input)
            .each_with_index
            .map { |letter, i| i.zero? ? letter : letter + (' ' * (i * 2 - 1)) + letter }

    lower = upper.reverse
    lower.shift
    diamond = upper + lower

    diamond.map { |row| row.center(diamond.length) }.join("\n") + "\n"
  end
end
