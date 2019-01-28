module Pangram

  ALPHABET = 'abcdefghijklmnopqrstuvwxyz'

  def self.pangram?(sentence)
    sentence.downcase.scan(/[a-z]/).uniq.count == ALPHABET.length
  end

end