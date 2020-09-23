# frozen_string_literal: true

# Transpose
module Transpose
  def self.transpose(input)
    rows = input.split("\n").map(&:chars)
    result = []

    until rows.empty?
      rows.each { |row| result << (row.slice!(0) || ' ') }
      result << "\n"
      rows.pop while rows.last&.empty?
    end

    result.join.rstrip
  end
end
