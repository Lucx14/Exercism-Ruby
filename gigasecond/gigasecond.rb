module Gigasecond

  # Time from...
  def self.from(time=Time.now)
    time + 1000000000
  end
end
