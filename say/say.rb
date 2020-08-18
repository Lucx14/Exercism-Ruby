# frozen_string_literal: true

# Say
class Say
  MAX_NUMBER = 999_999_999_999
  TRANSLATION = {
    0 => [nil, nil, nil],
    1 => %w[one ten eleven],
    2 => %w[two twenty twelve],
    3 => %w[three thirty thirteen],
    4 => %w[four forty fourteen],
    5 => %w[five fifty fifteen],
    6 => %w[six sixty sixteen],
    7 => %w[seven seventy seventeen],
    8 => %w[eight eighty eighteen],
    9 => %w[nine ninety nineteen]
  }.freeze

  attr_reader :number
  def initialize(number)
    raise ArgumentError if number.negative? || number > MAX_NUMBER

    @number = number
  end

  def in_english
    return 'zero' if number.zero?

    compact_join(chunks(digits(number), 3)
      .zip(%w[thousand million billion])
      .map { |data| digits(data[0]).length == 3 ? [format_3(data[0]), data[1]] : [format_2(data[0]), data[1]] }
      .flatten
      .reverse
      .drop(1)
      .each_slice(2)
      .map { |data| data unless data[0].nil? })
  end

  def format_3(number)
    compact_join(chunks(digits(number), 2)
      .zip(['hundred'])
      .map { |data| [format_2(data[0]), data[1]] }
      .flatten
      .reverse)
  end

  def format_2(number)
    if number < 10
      TRANSLATION[number][0]
    elsif number.between?(11, 19)
      TRANSLATION[digits(number)[1]][2]
    elsif (number % 10).zero?
      TRANSLATION[digits(number)[0]][1]
    elsif number % 10 != 0
      digits(number).reverse.each_with_index.map { |num, i| TRANSLATION[num][i] }.reverse.join('-')
    end
  end

  def digits(number)
    number.to_s.chars.map(&:to_i)
  end

  def chunks(array_of_numbers, slice_size)
    array_of_numbers
      .reverse
      .each_slice(slice_size)
      .map(&:reverse)
      .map(&:join)
      .map(&:to_i)
  end

  def compact_join(array)
    array
      .compact
      .join(' ')
  end
end
