# frozen_string_literal: true

# Pig Latin
class PigLatin
  VOWEL_SOUNDS = %w[a e i o u yt xr].freeze
  CONSONANTS = [].freeze
  PIG_END = 'ay'

  attr_reader :text

  def initialize(text)
    @text = text
  end

  def self.translate(input)
    PigLatin.new(input).translate
  end

  def translate
    if starts_with_vowel_sound?
      return "#{text}#{PIG_END}"
    end
  
  end

  def starts_with_vowel_sound?
    first = text.chars.first
    if %w[y x].include?(first)
      first = text.chars.each_slice(2).first.join
    end

    VOWEL_SOUNDS.include?(first)
  end

end


# vowel sounds:
# a, e, i, o, u, yt, xr
# add "ay" to end

# consonant sounds
# one or more consts move to the end of word then add "ay"

# 
# If a word contains a "y" after a consonant cluster or as the second letter in a two letter word it makes a vowel sound (e.g. "rhythm" -> "ythmrhay", "my" -> "ymay").



