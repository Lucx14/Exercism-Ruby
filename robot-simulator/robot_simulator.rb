# frozen_string_literal: true

# Robot Simulator
class Robot
  attr_accessor :bearing, :coordinates

  def initialize(bearing = :north, coordinates = [0, 0])
    @bearing = bearing
    @coordinates = coordinates
  end

  def orient(direction)
    raise ArgumentError unless DIRECTIONS.include?(direction)

    self.bearing = direction
  end

  def turn_right
    rotate_direction(1)
  end

  def turn_left
    rotate_direction(-1)
  end

  def at(x_coordinate, y_coordinate)
    self.coordinates = [x_coordinate, y_coordinate]
  end

  def advance
    case bearing
    when :north then at(coordinates.first, coordinates.last + 1)
    when :east then at(coordinates.first + 1, coordinates.last)
    when :south then at(coordinates.first, coordinates.last - 1)
    when :west then at(coordinates.first - 1, coordinates.last)
    end
  end

  private

  DIRECTIONS = %i[north east south west].freeze

  def rotate_direction(direction)
    self.bearing = DIRECTIONS.rotate(direction)[DIRECTIONS.index(bearing)]
  end
end

# Simulator
class Simulator
  COMMANDS = { 'L' => :turn_left, 'R' => :turn_right, 'A' => :advance }.freeze

  def instructions(directions)
    directions.chars.map { |direction| COMMANDS[direction] }
  end

  def place(robot, x:, y:, direction:)
    robot.at(x, y)
    robot.orient(direction)
  end

  def evaluate(robot, commands)
    instructions(commands).each { |command| robot.send(command) }
  end
end
