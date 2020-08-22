# frozen_string_literal: true

# Matching Brackets
module Brackets
  BRACKETS = { '(' => ')', '[' => ']', '{' => '}' }.freeze

  def self.paired?(text)
    stack = []
    text.each_char do |char|
      stack << char if BRACKETS.keys.include?(char)
      if BRACKETS.values.include?(char)
        return false unless BRACKETS[stack.pop] == char
      end
    end

    stack.empty?
  end
end
