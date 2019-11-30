module Isogram
  extend self

  def isogram?(input)
    letters = input.downcase.scan(/[a-z]/i)
    letters.uniq.count == letters.count
  end
end
