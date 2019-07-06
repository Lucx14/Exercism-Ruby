module Hamming
  ERROR_MESSAGE = "Error: both strands must be of the same length"
  def self.compute(strand1, strand2)
    raise ArgumentError.new(ERROR_MESSAGE) if strand1.length != strand2.length
    count = 0
    n = strand1.length - 1
    (0..n).each { |i| count += 1 if strand1[i] != strand2[i] }
    count
  end
end
