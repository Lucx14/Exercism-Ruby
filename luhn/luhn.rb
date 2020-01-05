class Luhn
  attr_reader :number

  def initialize(number)
    @number = number
  end

  def valid?
    validate_length &&
    validate_chars && 
    validate_luhn
  end

  def self.valid?(number)
    new(number).valid?
  end

  private

  def validate_luhn
    numbers.reverse.each_with_index.map do |number, index|
      if index % 2 != 0
        num = (number * 2)
        num > 9 ? num - 9 : num
      else
        number
      end
    end.sum % 10 == 0
  end

  def validate_chars
    number.strip.scan(/\D/).reject{|x| x =~ /\s+/}.empty?
  end

  def validate_length
    number.strip.length > 1
  end

  def numbers
    number.scan(/\d/).map(&:to_i)
  end
end

