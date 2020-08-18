# frozen_string_literal: true

# Queen Attack!
class Queens
  def attack?
    same_row? || same_col? || same_diagonal?
  end

  private

  attr_reader :white, :black

  def initialize(params = {})
    @white = params[:white]
    @black = params[:black]
    validate_positions
  end

  def same_row?
    white[0] == black[0]
  end

  def same_col?
    white[1] == black[1]
  end

  def same_diagonal?
    (white[0] - black[0]).abs == (white[1] - black[1]).abs
  end

  def validate_positions
    position_valid?(white) unless white.nil?
    position_valid?(black) unless black.nil?
  end

  def position_valid?(array)
    array.each { |i| raise ArgumentError unless i.between?(0, 7) }
  end
end
