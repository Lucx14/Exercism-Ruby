class Cipher
  attr_reader :key

  def initialize(key = 'aaaaaaaaaaaaaaaaaa')
    @key = key
  end

  def encode(plaintext)
    plaintext
  end

  def decode(ciphertext)
    ciphertext
  end
end
