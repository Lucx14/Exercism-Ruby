# frozen_string_literal: true

# Saddle Points
class Matrix
  attr_reader :rows, :columns

  def initialize(matrix)
    @rows = matrix.split("\n").map(&:split).map { |row| row.map(&:to_i) }
    @columns = rows.transpose
  end

  def saddle_points
    rows.each_with_index.map do |row, row_index|
      [row_index, row.index(row.max)] if saddle_point?(row, columns[row.index(row.max)])
    end.compact
  end

  private

  def saddle_point?(row, col)
    row.max == col.min
  end
end
