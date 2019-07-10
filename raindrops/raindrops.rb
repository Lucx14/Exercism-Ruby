module Raindrops
  MAP = { 3 => "Pling", 5 => "Plang", 7 => "Plong" }
  def self.convert(arg)
    arr = [3, 5, 7].select { |divisor| arg % divisor == 0 }.map { |i| MAP[i] }
    arr.length == 0 ? arg.to_s : arr.join
  end
end
