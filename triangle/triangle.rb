class Triangle

  def initialize(dimensions)
    @dimensions = dimensions
  end

  def equilateral?
    triangle? && equal_sides_count.size == 1
  end

  def isosceles?
    triangle? && equal_sides_count.size <= 2
  end

  def scalene?
    triangle? && equal_sides_count.size == 3
  end

  private

  attr_reader :dimensions

  def equal_sides_count
    dimensions
      .group_by{|e| e}
      .map{|k, v| [k, v.length]}
      .to_h
  end

  def triangle?
    sum_of_sides && !dimensions.any?(0)
  end

  def sum_of_sides
    x = dimensions[0] + dimensions[1] > dimensions[2]
    y = dimensions[1] + dimensions[2] > dimensions[0]
    z = dimensions[2] + dimensions[0] > dimensions[1]
    x && y && z
  end
end
