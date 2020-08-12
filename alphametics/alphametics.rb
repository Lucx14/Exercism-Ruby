# frozen_string_literal: true

# Alphametics
class Alphametics
  def self.solve(puzzle)
    Alphametics.new(puzzle).find_result
  end

  def find_result
    return {} if invalid_puzzle?

    i = iterator
    until unique_values? && equation_satisfied?
      i -= 1
      letters.each_with_index do |letter, index|
        translation[letter] = i.to_s.split('')[index].to_i
      end
    end

    translation.sort.to_h
  end

  private

  attr_reader :translation, :question, :answer

  def initialize(puzzle)
    @translation = build_mapping(puzzle)
    @question = build_question(puzzle)
    @answer = build_answer(puzzle)
  end

  def build_mapping(puzzle)
    result = {}
    puzzle.gsub(/[^a-zA-Z]/i, '').split('').uniq.each do |letter|
      result[letter] = 9
    end
    result
  end

  def build_question(puzzle)
    puzzle.split('==')[0].strip.split('+').map(&:strip)
  end

  def build_answer(puzzle)
    puzzle.split('==')[1].strip
  end

  def iterator
    translation.values.join.to_i
  end

  def letters
    translation.keys.sort
  end

  def numbers
    translation.values.uniq.sort
  end

  def unique_values?
    translation.values.uniq.length == translation.length
  end

  def equation_satisfied?
    left_sum == right_sum && valid_answer?
  end

  def left_sum
    question.map { |num| num.split('').map { |letter| translate(letter) }.join.to_i }.sum
  end

  def right_sum
    answer.split('').map { |letter| translate(letter) }.join.to_i
  end

  def valid_answer?
    right_sum.to_s.length == answer.length
  end

  def invalid_puzzle?
    return true if letters.length == 2

    question.each do |addend|
      return true if addend.length > answer.length
    end
    false
  end

  def translate(letter)
    translation[letter]
  end
end
