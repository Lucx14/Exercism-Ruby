# frozen_string_literal: true

# Proverb
class Proverb
  def to_s
    [*lines, last_line].join("\n")
  end

  private

  attr_reader :inputs, :qualifier

  def initialize(*args, qualifier: nil)
    @inputs = args
    @qualifier = qualifier
  end

  def qualified_input
    [qualifier, inputs.first].compact.join(' ')
  end

  def lines
    inputs.each_cons(2).map do |want, lost|
      "For want of a #{want} the #{lost} was lost."
    end
  end

  def last_line
    "And all for the want of a #{qualified_input}."
  end
end
