# frozen_string_literal: true

# Pig Latin
class PigLatin
  def self.translate(input)
    new(input).translate
  end

  def translate
    english
      .split(' ')
      .map { |word| translate_word(word) }
      .join(' ')
  end

  private

  VOWEL_SOUNDS = %w[a e i o u yt xr].freeze
  TRIGRAPHS = %w[sch thr squ].freeze
  DIGRAPHS = %w[ch qu th rh].freeze
  SUFFIX = 'ay'

  attr_reader :english

  def initialize(english)
    @english = english
  end

  def translate_word(word)
    word.chars.rotate(rotation(word)).join + SUFFIX
  end

  def prefixed_with?(sounds, word)
    sounds.any? { |sound| word.start_with?(sound) }
  end

  def rotation(word)
    return 0 if prefixed_with?(VOWEL_SOUNDS, word)
    return 3 if prefixed_with?(TRIGRAPHS, word)
    return 2 if prefixed_with?(DIGRAPHS, word)

    1
  end
end
