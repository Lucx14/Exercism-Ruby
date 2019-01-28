module Pangram

  ALPHABET = 'abcdefghijklmnopqrstuvwxyz'

  def self.pangram?(sentence)
    x = {}
    sentence.downcase.scan(/[a-zA-Z]/).each do |letter|
      x.key?(letter) ? x[letter] += 1 : x[letter] = 1
    end

    true if x.size == ALPHABET.length
  end

end