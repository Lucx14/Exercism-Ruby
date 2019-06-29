module Hamming

  def self.compute(strand1, strand2)
    raise ArgumentError.new("Error") if strand1.length != strand2.length

    count = 0
    strand1.split("").each_with_index { |val, index| count += 1 if val != strand2.split("")[index] }
  
    count
  end
end
