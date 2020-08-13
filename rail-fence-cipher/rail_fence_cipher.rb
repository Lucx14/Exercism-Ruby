# frozen_string_literal: true

# Rail fence cipher
module RailFenceCipher
  def self.encode(plain_text, rails)
    return plain_text if rails == 1

    result = {}
    (1..rails).each { |rail| result[rail] = [] }

    rail = 1
    down = true

    plain_text.split('').each do |letter|
      result[rail] << letter

      down ? rail += 1 : rail -= 1
      if rail == rails
        down = false
      elsif rail == 1
        down = true
      end


    end

    result.map{ |_, v| v }.flatten.join
 
  end

  def self.decode(encoded_text, rails)
    return encoded_text if rails == 1
    return '' if encoded_text.length == 0
    res = {}
    (1..rails).each { |rail| res[rail] = ['.'].cycle(encoded_text.length).to_a }

    str = ['?'].cycle(encoded_text.length).to_a.join

    rail = 1
    down = true
    str.split('').each_with_index do |placeholder, i|
      res[rail][i] = placeholder

      down ? rail += 1 : rail -= 1
      if rail == rails
        down = false
      elsif rail == 1
        down = true
      end

    end

    grid = res.map { |_, v| v.join }.join("\n")

    enc = encoded_text
    until enc.length == 0
     
      grid.sub!(/[?]/, enc[0])
      enc[0] = ''
    end

    grid_arr = grid.split("\n")

    res2 = {}
    (1..rails).each { |rail| res2[rail] = grid_arr[rail - 1] }

    word = []

    rail = 1
    index = 0
    down = true
    
    until word.length == 22
      word << res2[rail][index]
      index += 1

      down ? rail += 1 : rail -= 1
      if rail == rails
        down = false
      elsif rail == 1
        down = true
      end
    end

    word.join
  end
end
