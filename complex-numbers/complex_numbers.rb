# frozen_string_literal: true

# Complex Number
class ComplexNumber
  attr_reader :real, :imaginary

  def initialize(real, imaginary)
    @real = real.to_f
    @imaginary = imaginary.to_f
  end

  def *(other)
    new(
      real * other.real - imaginary * other.imaginary,
      imaginary * other.real + real * other.imaginary
    )
  end

  def /(other)
    new(
      (real * other.real + imaginary * other.imaginary) / other.sq_abs,
      (imaginary * other.real - real * other.imaginary) / other.sq_abs
    )
  end

  def sq_abs
    real**2 + imaginary**2
  end

  def +(other)
    new(real + other.real, imaginary + other.imaginary)
  end

  def -(other)
    new(real - other.real, imaginary - other.imaginary)
  end

  def abs
    Math.sqrt(real**2 + imaginary**2)
  end

  def conjugate
    new(real, -imaginary)
  end

  def exp
    new(Math.exp(real) * Math.cos(imaginary), Math.exp(real) * Math.sin(imaginary).floor)
  end

  def ==(other)
    self.class == other.class &&
      hash == other.hash
  end
  alias eql? ==

  def hash
    [real, imaginary].hash
  end

  private

  def new(real, imaginary)
    self.class.new(real, imaginary)
  end
end
