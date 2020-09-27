# frozen_string_literal: true

# Binary Search
class BinarySearch
  attr_reader :data

  def initialize(data)
    @data = data
  end

  def search_for(element)
    return nil if data.empty?

    index_of_element(data, element)
  end

  def index_of_element(data_set, element, buffer = [])
    return nil if data_set.length == 1 && element != data_set[0]

    mid_index = data_set.length / 2
    if element == data_set[mid_index]
      mid_index + buffer.flatten.length
    elsif element < data_set[mid_index] && data_set.length > 1
      index_of_element(data_set[0..mid_index - 1], element, buffer)
    else
      buffer << data_set[0..mid_index]
      index_of_element(data_set[mid_index + 1..data_set.length - 1], element, buffer)
    end
  end
end
