class Series

  attr_reader :sample

  def initialize(sample)
    @sample = sample
  end

  def slices(n)
    raise ArgumentError if n > sample.length
    final = []
    sample.split('').each_index do |i|
      final << sample.slice(i, n)
    end

    final.reject { |k| k.length < n}
  end
end
