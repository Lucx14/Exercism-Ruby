# frozen_string_literal: true

# Affine Cipher
class Affine
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

  A = ('a'..'z').to_a
  L = A.length

  attr_reader :key1, :key2

  def initialize(key1, key2)
    raise ArgumentError unless coprime(key1)

    @key1 = key1
    @key2 = key2
  end

  def format(string)
    string.gsub(/[^0-9a-zA-Z]/, '').downcase.chars
  end

  def encode_letter(letter)
    new_index = ((key1 * A.index(letter)) + key2) % L
    A[new_index]
  end

  def decode_letter(letter)
    new_index = (mmi * (A.index(letter) - key2)) % L
    A[new_index]
  end

  def coprime(key)
    (select_primes(key) & select_primes(L))
      .reject { |x| x == 1 }
      .empty?
  end

  def select_primes(number)
    (1..number).select { |n| (number % n).zero? }
  end

  def mmi
    (0...L).find { |n| ((key1 * n) % L) == 1 }
  end
end
