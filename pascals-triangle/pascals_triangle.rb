# frozen_string_literal: true

# Pascals Triangle
class Triangle
  attr_reader :number_of_rows

  def initialize(number_of_rows)
    @number_of_rows = number_of_rows
  end

  def rows
    result = []
    (1..number_of_rows).map do |row|
      batch = []
      until batch.length == row
        batch << 1
        break if result.empty?

        if result.length > 1
          sum_nums(result[row - 2]).each { |num| batch << num }
          batch << 1
        end
      end

      result << batch
    end
    result
  end

  def sum_nums(arr)
    arr.each_with_index.map do |el, i|
      el + arr[i + 1] if i < arr.length - 1
    end.compact
  end
end
