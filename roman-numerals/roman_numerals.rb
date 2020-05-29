class Numeric
  def to_roman
    numerals = {
      1 => %w[I X C M],
      2 => %w[II XX CC MM],
      3 => %w[III XXX CCC MMM],
      4 => %w[IV XL CD],
      5 => %w[V L D],
      6 => %w[VI LX DC],
      7 => %w[VII LXX DCC],
      8 => %w[VIII LXXX DCCC],
      9 => %w[IX XC CM]
    }

    result = []
    to_s.split('').reverse.map(&:to_i).each_with_index do |x, i|
      result << numerals[x][i] unless x.zero?
    end

    result.reverse.join('')
  end
end
