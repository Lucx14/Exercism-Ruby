class Cipher
  attr_reader :key

  def initialize(key = 'aaaaaaaaaaaaaaaaaa')
    validate_key(key)
    @key = key
  end

  def encode(plaintext)
    plaintext
  end

  def decode(ciphertext)
    ciphertext
  end

  private

  def validate_key(key)
    raise ArgumentError unless key.length.positive? && key.scan(/[^a-z]/).empty?
  end
end
