class WordProblem
  def answer
    raise ArgumentError if numbers.length < 2

    calculate
  end

  private

  attr_reader :operations, :numbers

  def initialize(phrase)
    @operations = extract_operations(phrase)
    @numbers = extract_numbers(phrase)
  end

  def extract_operations(phrase)
    words = phrase
            .split(/[-?0-9]/)
            .map(&:strip)
            .reject(&:empty?)
    words.shift
    words
  end

  def extract_numbers(phrase)
    phrase
      .gsub('?', '')
      .split(/[^-?0-9]/)
      .reject(&:empty?)
      .map(&:to_i)
  end

  def calculate
    total = 0
    numbers.each_with_index do |num, i|
      next total += num if i.zero?

      case operations[i - 1]
      when 'plus' then total += num
      when 'minus' then total -= num
      when 'multiplied by' then total *= num
      when 'divided by' then total /= num
      end
    end
    total
  end
end
