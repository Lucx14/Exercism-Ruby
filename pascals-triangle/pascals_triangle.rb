# frozen_string_literal: true

# Pascals Triangle
class Triangle
  attr_reader :number_of_rows

  def initialize(number_of_rows)
    @number_of_rows = number_of_rows
  end

  def rows
    result = [[1]]
    starting_point = 010
    p number_of_rows


    until result.length == number_of_rows - 1 do
      next_batch = []
    end
    p (1..number_of_rows).map do |row|
      

    end
  end

end
# the row number == the length of the row