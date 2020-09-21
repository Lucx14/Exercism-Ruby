# frozen_string_literal: true

# Custom Set
class CustomSet
  attr_reader :data

  def initialize(data)
    @data = data.uniq
  end

  def member?(element)
    data.include?(element)
  end

  def add()

  end

  def empty?
    data.empty?
  end

  def subset?(other)
    if other.data.empty? && data.empty?
      true
    elsif other.data.length.positive? && data.empty?
      true
    elsif other.data.sort == data
      true
    elsif (other.data - data).any? && (data - other.data).empty?
      true
    else
      false
    end
  end
end
