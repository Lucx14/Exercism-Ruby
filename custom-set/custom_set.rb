# frozen_string_literal: true

# Custom Set
class CustomSet
  attr_reader :data

  def initialize(data = [])
    @data = data.uniq
  end

  def member?(element)
    data.include?(element)
  end

  def add(element)
    data << element unless data.member?(element)
    self
  end

  def empty?
    data.empty?
  end

  def subset?(other)
    data.all? { |element| other.data.member?(element) }
  end

  def disjoint?(other)
    # (data - other.data) == data
    data.none? { |element| other.data.member?(element) }
  end

  def ==(other)
    subset?(other) && other.subset?(self)
  end

  def intersection(other)
    CustomSet.new(data.select { |e| other.member?(e) })
  end

  def difference(other)
    CustomSet.new(data.reject { |e| other.member?(e) })
  end

  def union(other)
    CustomSet.new(data + other.data)
  end
end
