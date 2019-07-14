module Raindrops
  MAP = { 3 => "Pling", 5 => "Plang", 7 => "Plong" }
  def self.convert(number)
    named_factors = MAP.keys.select { |divisor| number % divisor == 0 }.map { |i| MAP[i] }
    named_factors.empty? ? number.to_s : named_factors.join
  end
end
