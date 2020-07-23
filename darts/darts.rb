# Darts
class Darts
  attr_reader :x, :y

  def initialize(x, y)
    @x = x 
    @y = y 
  end


  def score
    d = Math.sqrt(x**2 + y**2)
    
    if d > 10
      0
    elsif d > 5
      1
    elsif d > 1
      5
    else
      10
    end
  end
end
