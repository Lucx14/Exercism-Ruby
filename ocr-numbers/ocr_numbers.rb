# frozen_string_literal: true

# OCR Numbers
class OcrNumbers
  TRANSLATION = %w[
    X_X|X||_|XXX
    XXXXX|XX|XXX
    X_XX_||_XXXX
    X_XX_|X_|XXX
    XXX|_|XX|XXX
    X_X|_XX_|XXX
    X_X|_X|_|XXX
    X_XXX|XX|XXX
    X_X|_||_|XXX
    X_X|_|X_|XXX
  ].freeze

  attr_reader :sanitized_input

  def initialize(binary_font)
    @sanitized_input = sanitize_input(binary_font)
  end

  def convert
    sanitized_input
      .map { |section| section.map { |num| translate(num) } }
      .map(&:join)
      .join(',')
  end

  def self.convert(input)
    OcrNumbers.new(input).convert
  end

  def translate(input)
    raise ArgumentError unless input.length == 12
    return '?' unless TRANSLATION.include?(input)

    TRANSLATION.index(input)
  end

  def sanitize_input(input)
    input
      .split("\n")
      .each_slice(4)
      .map { |item| format_line(item) }
  end

  def format_line(input)
    input
      .map { |line| line.chars.each_slice(3).map(&:join) }
      .transpose.map(&:join)
      .map { |line| line.tr(' ', 'X') }
  end
end
