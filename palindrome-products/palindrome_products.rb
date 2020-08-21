# frozen_string_literal: true

# Palindrome Products
class Palindromes
  attr_reader :max_factor, :min_factor
  def initialize(params = {})
    @max_factor = params[:max_factor] || 1
    @min_factor = params[:min_factor] || 1
  end

  def generate
    result = []
    (min_factor..max_factor).each do |num|
      (min_factor..max_factor).each { |num2| result << [num, num2] }
    end
    i = result.map { |arr| arr[0] * arr[1] }
    @palindromes = i.map { |num| num if palindrome?(num) }.compact
    # p @palindromes
    self
  end

  def palindrome?(num)
    num.to_s.chars.reverse.join.to_i == num
  end

  def largest
    @target_palindrome = @palindromes.max
    self
  end

  def smallest
    @target_palindrome = @palindromes.min
    self
  end

  def value
    @target_palindrome
  end

  def factors
    result = []
    (min_factor..max_factor).each do |num|
      (min_factor..max_factor).each { |num2| result << [num, num2] if num * num2 == @target_palindrome }
    end
    result.map(&:sort).uniq
  end
end