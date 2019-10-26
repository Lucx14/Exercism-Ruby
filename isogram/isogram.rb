module Isogram
  extend self

  def isogram?(input)
    letters = input.scan(/[a-z]/i).map(&:downcase)
    letter_count = letters.group_by{ |element| element }.map{|k, v| [k, v.length]}.to_h
    letter_count.select{|k,v| v > 1}.empty?
  end
end
