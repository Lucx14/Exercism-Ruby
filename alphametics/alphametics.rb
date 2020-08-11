# frozen_string_literal: true

# Alphametics
module Alphametics
  def self.solve(puzzle)

    # Init the result hash
    result = {}
    puzzle.gsub(/[^a-zA-Z]/i, '').split('').uniq.each do |letter|
      result[letter] = 9
    end

    # i will start at 9999
    iterator = result.map { |_, v| v }.join.to_i

    keys = result.map { |k, _v| k }.sort

    return {} if keys.length == 2

    # isolate the addends
    addends = puzzle.split('==')[0].strip.split('+').map(&:strip)

    # calc maxiumum possible answer...
    max_possible_answer = addends.map do |num|
      num.split('').map { |yy| yy.gsub(/[a-zA-Z]/, result[yy].to_s) }.join
    end.map(&:to_i).sum

    # extract answer...
    answer = puzzle.split('==')[1].strip

    addends.each do |addend|
      return {} if addend.length > answer.length
    end

    # determine first letter of answer....if possible
    if answer.length == max_possible_answer.to_s.length
      result[answer[0]] = max_possible_answer.to_s[0].to_i
    end

    # start loop....
    until unique_values?(result) && equation_satisfied?(puzzle, result)

      iterator -= 1
      numbers = iterator.to_s.split('')
      keys.each_with_index do |key, i|
        result[key] = numbers[i].to_i
      end
    end

    # return result if loop satisfied....
    result.sort.to_h
  end

  def self.unique_values?(hash)
    hash.map { |_, v| v }.uniq.length == hash.length
  end

  def self.equation_satisfied?(puzzle, hash)
    question = puzzle.split('==')[0].strip.split('+').map(&:strip).map do |num|
      num.split('').map { |yy| yy.gsub(/[a-zA-Z]/, hash[yy].to_s) }.join
    end.map(&:to_i).sum

    answer = puzzle.split('==')[1].strip.split('').map do |num|
      num.split('').map { |yy| yy.gsub(/[a-zA-Z]/, hash[yy].to_s) }.join
    end.join.to_i

    question == answer && answer.to_s.length == puzzle.split('==')[1].strip.length
  end
end
