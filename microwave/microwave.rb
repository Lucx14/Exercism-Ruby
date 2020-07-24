class Microwave

  attr_reader :seconds
  def initialize(seconds)
    @seconds = seconds
  end

  def timer
    arr = seconds.to_s.rjust(4, '0').chars.each_slice(2).map(&:join)
    seconds = arr[1].to_i.divmod(60)
    remainder = seconds[0]
    mins = (arr[0].to_i + remainder)
    [mins.to_s, seconds[1].to_s]
      .map { |num| num.rjust(2, '0') }.join(':')
  end
end


