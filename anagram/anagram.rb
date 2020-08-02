# frozen_string_literal: true

# Anagram
class Anagram
  def match(list)
    list.select { |other_word| anagram?(word, other_word) }
  end

  private

  attr_reader :word

  def initialize(word)
    @word = word
  end

  def format(word)
    word.downcase.chars.sort.join
  end

  def anagram?(word, other_word)
    format(word) == format(other_word) &&
      other_word.downcase != word.downcase
  end
end
