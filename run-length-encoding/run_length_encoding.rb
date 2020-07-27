# frozen_string_literal: true

# Resistor Run Length Encoding
module RunLengthEncoding
  def self.encode(input)
    input
      .scan(/(([a-zA-z\s])\2*)/)
      .map(&:first)
      .map { |group| group.length == 1 ? group.chars.first : group.length.to_s + group.chars.first }
      .join
  end

  def self.decode(input)
    input
      .scan(/\d+[a-zA-Z\s]{1}|[a-zA-Z\s]{1}/)
      .map { |group| group.split(/(?<=\d)(?=[A-Za-z\s])/) }
      .map { |group| group.length == 1 ? group.first : group.last * group.first.to_i }
      .join
  end
end
