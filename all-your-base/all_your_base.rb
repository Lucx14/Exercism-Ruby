# frozen_string_literal: true

# Base Converter
module BaseConverter
  def self.convert_to_decimal(digits, input_base)
    num = 0
    digits.reverse.each_with_index { |val, i| num += (val * input_base**i) }
    num.to_s.chars.map(&:to_i)
  end

  def self.convert_from_decimal(digits, output_base)
    result = []
    i = digits.join.to_i
    while i.positive?
      x = i.divmod(output_base)
      i = x[0]
      result.unshift(x[1])
    end
    return [0] if result.empty?

    result
  end

  def self.convert(input_base, digits, output_base)
    validate_args(digits, input_base, output_base)

    if output_base == 10
      convert_to_decimal(digits, input_base)
    elsif input_base == 10
      convert_from_decimal(digits, output_base)
    else
      convert_from_decimal(convert_to_decimal(digits, input_base), output_base)
    end
  end

  def self.validate_args(digits, input_base, output_base)
    raise ArgumentError if input_base <= 1
    raise ArgumentError if output_base <= 1
    raise ArgumentError if digits.any?(&:negative?)
    raise ArgumentError if digits.any? { |digit| digit >= input_base }
  end
end
