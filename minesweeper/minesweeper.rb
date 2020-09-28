# frozen_string_literal: true

# Minesweeper
class Board
  def self.transform(input)
    Board.new(input).reveal
  end

  def reveal
    input
      .map(&:chars)
      .each_with_index.map do |row, row_index|
        row.each_with_index.map do |cell, cell_index|
          cell == ' ' ? count_bombs(row_index, cell_index) : cell
        end
      end.map(&:join)
  end

  private

  attr_reader :input

  def initialize(input)
    @input = input
    validate_board
  end

  def count_bombs(row_index, cell_index)
    counter = 0
    ADJACENT_CELLS.each do |diff|
      coordinates = [row_index, cell_index].zip(diff).map(&:sum)
      counter += 1 if input[coordinates.first][coordinates.last] == BOMB
    end
    counter.positive? ? counter : ' '
  end

  def validate_board
    raise ArgumentError unless rows_valid? && board_dimensions_valid?
  end

  def rows_valid?
    input.each_with_index.all? do |row, i|
      if i.zero? || (i == input.length - 1)
        OUTER_VALIDATION.match(row)
      else
        INNER_VALIDATION.match(row)
      end
    end
  end

  def board_dimensions_valid?
    input.map(&:length).uniq.length == 1
  end

  OUTER_VALIDATION = /\A\+-+\+\z/.freeze
  INNER_VALIDATION = /\A\|(\*|\s)+\|\z/.freeze
  BOMB = '*'
  ADJACENT_CELLS = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]].freeze
end
