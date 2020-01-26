class Clock
  MINUTES_PER_HOUR = 60
  MINUTES_PER_DAY = 1440
  TIME_FORMAT = "%02d:%02d"

  attr_reader :time

  def initialize(hour: 0, minute: 0)
    @time = total_minutes(hour, minute)
  end

  def to_s
    TIME_FORMAT % time.divmod(MINUTES_PER_HOUR)
  end

  def +(clock)
    Clock.new(hour: 0, minute: (time + clock.time))
  end

  def -(clock)
    Clock.new(hour: 0, minute: (time - clock.time))
  end

  def ==(clock)
    self.class == clock.class &&
    hash == clock.hash
  end
  alias :eql? :==

  def hash
    [@time].hash
  end

  private

  def total_minutes(hour, minute)
    (hour * MINUTES_PER_HOUR + minute) % MINUTES_PER_DAY
  end
end
