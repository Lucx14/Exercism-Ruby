# frozen_string_literal: true

# List ops
module ListOps
  def self.arrays(arr)
    count = 0
    arr.each { count += 1 }
    count
  end

  def self.reverser(arr)
    result = []
    result << arr.pop until arr.empty?
    result
  end

  def self.concatter(arr1, arr2)
    result = []
    result << arr1 << arr2
    result.flatten
  end

  def self.mapper(arr)
    result = []
    arr.each { |n| result << yield(n) }
    result
  end

  def self.filterer(arr, &block)
    result = []
    arr.each { |n| result << n if block.call(n) }
    result
  end

  def self.sum_reducer(arr)
    sum = 0
    sum += arr.pop until arr.empty?
    sum
  end

  def self.factorial_reducer(arr)
    factorial = 1
    factorial *= arr.pop until arr.empty?
    factorial
  end
end
