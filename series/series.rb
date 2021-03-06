class Series

  attr_reader :sample

  def initialize(sample)
    @sample = sample
  end

  def slices(n)
    raise ArgumentError if n > sample.length
    sample.split('').each_cons(n).map(&:join)
  end
end
