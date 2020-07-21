# frozen_string_literal: true

# Affine Cipher
class Affine
  ALPHABET = ('a'..'z').to_a

  attr_reader :key1, :key2

  def initialize(key1, key2)
    raise ArgumentError unless coprime(key1, ALPHABET.length)

    @key1 = key1
    @key2 = key2
  end

  def encode(plain_text)
    format(plain_text)
      .map { |c| c =~ /[a-z]/ ? encode_letter(c) : c }
      .each_slice(5)
      .map(&:join)
      .join(' ')
  end

  def decode(ciphertext)
    format(ciphertext)
      .map { |c| c =~ /[a-z]/ ? decode_letter(c) : c }
      .join
  end

  private

  def format(string)
    string.gsub(/[^0-9a-zA-Z]/, '').downcase.chars
  end

  def encode_letter(letter)
    new_index = ((key1 * ALPHABET.index(letter)) + key2) % ALPHABET.length
    ALPHABET[new_index]
  end

  def decode_letter(letter)
    new_index = (mmi * (ALPHABET.index(letter) - key2)) % ALPHABET.length
    ALPHABET[new_index]
  end

  def coprime(key, alphabet_length)
    (select_primes(key) & select_primes(alphabet_length))
      .reject { |x| x == 1 }
      .empty?
  end

  def select_primes(number)
    (1..number).select { |n| (number % n).zero? }
  end

  def mmi
    (0...ALPHABET.length).find { |number| ((key1 * number) % ALPHABET.length) == 1 }
  end
end

# Decryption
# D(y) = a^-1(y - b) mod m
# where y is the numeric value of an encrypted letter, ie. y = E(x)
# it is important to note that a^-1 is the modular multiplicative inverse of a mod m
# the modular multiplicative inverse of a only exists if a and m are coprime.

# Ciphertext is written out in groups of fixed length,
# the traditional group size being 5 letters,
# and punctuation is excluded.
#  This is to make it harder to guess things based on word boundaries
