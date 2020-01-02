class Scrabble
  LETTER_VALUES = [
    [%w(A E I O U L N R S T), [1]],
    [%w(D G), [2]],
    [%w(B C M P), [3]],
    [%w(F H V W Y), [4]],
    [%w(K), [5]],
    [%w(J X), [8]],
    [%w(Q Z), [10]]
  ].freeze
  private_constant :LETTER_VALUES

  attr_reader :word

  def initialize(word)
    @word = word
  end

  def score
    letters.sum{ |letter| values[letter] }
  end

  def self.score(word)
    new(word).score
  end

  private

  def letters
    word.to_s.strip.upcase.chars
  end

  def values
    LETTER_VALUES.flat_map{ |x| x[0].product(x[1])}.to_h
  end
end
