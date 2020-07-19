# frozen_string_literal: true

# Rotational Cipher
module RotationalCipher
  ALPHABET = 'abcdefghijklmnopqrstuvwxyz'

  def self.rotate(phrase, num)
    res = []
    phrase.chars.each do |char|
      res << (char.match(/[a-zA-z]/).nil? ? char : run_rotation(char, num))
    end
    res.join
  end

  def self.run_rotation(char, num)
    if char.downcase == char
      ALPHABET[(ALPHABET.index(char) + (num % 26)) % 26]
    else
      ALPHABET[(ALPHABET.index(char.downcase) + (num % 26)) % 26].upcase
    end
  end
end
