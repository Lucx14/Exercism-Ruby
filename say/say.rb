class Say
  MAP = {
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
  }

  attr_reader :number
  def initialize(number)
    raise ArgumentError if number < 0 || number > 999999999999
    @number = number
  end

  def in_english
    return "zero" if number == 0

    nums = number.to_s.chars.map(&:to_i)
    split_num = nums.reverse.each_slice(3).to_a.map(&:reverse).map(&:join).map(&:to_i).reverse
    yy = split_num.reverse.zip(['thousand', 'million', 'billion'])
    zz = yy.map do |data|
      if data[0].to_s.chars.length == 3
        [format_3(data[0]), data[1]]
      else
        [format_2(data[0]), data[1]]
      end
    end
    qq = zz.flatten.reverse.drop(1)
    qq.each_slice(2).to_a.map { |data| data unless data[0] == nil }.join(' ').strip
    # p zz.flatten.reverse.drop(1).join(' ').strip
  end

  def format_3(num)
    nums = num.to_s.chars.map(&:to_i)
    split_num = nums.reverse.each_slice(2).to_a.map(&:reverse).map(&:join).map(&:to_i).reverse
    split_num
      .reverse
      .zip(['hundred'])
      .map { |data| [format_2(data[0]), data[1]] }
      .flatten
      .compact
      .reverse
      .join(' ')
  end

  def format_2(num)
    raise ArgumentError if num.to_s.chars.length > 2

    result = []
    if num < 10
      MAP[num][0]
    elsif num > 10 && num < 20
      MAP[num.to_s.chars[1].to_i][2]
    elsif num.to_s.chars.length == 2 && num.to_s.chars[1] != '0'
      num.to_s.chars.reverse.each_with_index.map { |n, i| result << MAP[n.to_i][i] }
      result.reverse.join('-')
    elsif num.to_s.chars.length == 2 && num.to_s.chars[1] == '0'
      MAP[num.to_s.chars[0].to_i][1]
    end
  end
end
