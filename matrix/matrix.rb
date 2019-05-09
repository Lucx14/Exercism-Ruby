class Matrix

  def initialize(number_matrix)
    @number_matrix = number_matrix
  end

  def rows
    converter
  end

  def columns
    converter.transpose
  end

  private

  attr_reader :number_matrix
  
  def converter
    number_matrix.split("\n")
                 .map { |row| row.split(' ') }
                 .map { |row| row.map { |number| number.to_i } }
  end
end
