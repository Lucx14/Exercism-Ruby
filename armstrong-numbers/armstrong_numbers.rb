module ArmstrongNumbers
  extend self

  def include?(number)
    split_number = number.to_s.split('').map(&:to_i)
    split_number.map{|n| n ** split_number.length }.inject(0){|sum,x| sum + x } == number
  end
end
