# frozen_string_literal: true

# Collatz Conjecture
module CollatzConjecture
  def self.steps(int)
    raise ArgumentError if int <= 0

    return 0 if int == 1

    count = 0
    while int > 1
      int.even? ? int /= 2 : int = (int * 3) + 1
      count += 1
    end
    count
  end
end
