module Hamming
  ERROR_MESSAGE = "Error: both strands must be of the same length"
  def self.compute(strand1, strand2)
    raise ArgumentError.new(ERROR_MESSAGE) if strand1.length != strand2.length
    (0...strand1.length).count { |i| strand1[i] != strand2[i] }
  end
end
