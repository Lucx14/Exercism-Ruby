# frozen_string_literal: true

# ISBN verifier
module IsbnVerifier
  def self.valid?(str)
    isbn = str.gsub(/[-]/, '')
    return false unless isbn.match(/^\d{9}[\d|X]$/)

    sum = 0
    isbn
      .chars
      .reverse
      .each_with_index do |n, i|
        sum += n == 'X' ? 10 * (i + 1) : n.to_i * (i + 1)
      end
    (sum % 11).zero?
  end
end
