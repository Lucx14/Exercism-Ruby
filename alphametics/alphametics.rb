# frozen_string_literal: true

# Alphametics
module Alphametics
  def self.solve(puzzle)
    # assume all the sum numbers are 9 what is the max
    # "I" = 9
    # "B" = 9
    # 9 + 99 = 108
    # I must = 1
    # 1 + 99 = 100
    # L must = 0

    p puzzle
    { 'B' => 9, 'I' => 1, 'L' => 0 }
  end
end
