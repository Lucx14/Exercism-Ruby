class Cipher
  attr_reader :key

  ALPHABET = 'abcdefghijklmnopqrstuvwxyz'.freeze

  def initialize(key = 'aaaaaaaaaaaaaaaaaa')
    validate_key(key)
    @key = key
  end

  def encode(plaintext)
    zz = plaintext.split('').each_with_index.map { |_, i| ALPHABET.index(key[i]) }

    xx = plaintext.split('').each_with_index.map do |letter, i|
      ALPHABET[(ALPHABET.index(letter) + zz[i]) % 26]
    end.join
    xx
  end

  def decode(ciphertext)
    zz = ciphertext.split('').each_with_index.map { |_, i| ALPHABET.index(key[i]) }

    xx = ciphertext.split('').each_with_index.map do |letter, i|
      ALPHABET[ALPHABET.index(letter) - zz[i]]
    end.join('')
    xx
  end

  private

  def validate_key(key)
    raise ArgumentError unless key.length.positive? && key.scan(/[^a-z]/).empty?
  end
end
