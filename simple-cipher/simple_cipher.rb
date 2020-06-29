class Cipher
  attr_reader :key

  ALPHABET = 'abcdefghijklmnopqrstuvwxyz'.freeze

  def initialize(key = 'aaaaaaaaaaaaaaaaaa')
    validate_key(key)
    @key = key
  end

  def encode(plaintext)
    plaintext
      .split('')
      .each_with_index
      .map { |letter, i| ALPHABET[(ALPHABET.index(letter) + shift_pattern(plaintext)[i]) % 26] }
      .join
  end

  def decode(ciphertext)
    ciphertext
      .split('')
      .each_with_index
      .map { |letter, i| ALPHABET[ALPHABET.index(letter) - shift_pattern(ciphertext)[i]] }
      .join
  end

  private

  def validate_key(key)
    raise ArgumentError unless key.length.positive? && key.scan(/[^a-z]/).empty?
  end

  def shift_pattern(text)
    text.split('').each_with_index.map { |_, i| ALPHABET.index(key[i]) }
  end
end
