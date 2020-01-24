class Clock
  MINUTES_PER_HOUR = 60
  MINUTES_PER_DAY = 1440
  TIME_FORMAT = "%02d:%02d"

  attr_reader :hour, :minute

  def initialize(hour: 0, minute: 0)
    @hour = hour
    @minute = minute
  end

  def to_s
    TIME_FORMAT % total_minutes.divmod(MINUTES_PER_HOUR)
  end
x
  def +(clock)
    Clock.new(hour: (hour + clock.hour), minute: (minute + clock.minute))
  end

  def -(clock)
    Clock.new(hour: (hour - clock.hour), minute: (minute - clock.minute))
  end

  def ==(clock)
    self.to_s == clock.to_s
  end

  # def ==(clock)
  #   self.class == clock.class &&
  #   hour == clock.hour &&
  #   minute == clock.minute
  # end
  # alias :eql? :==

  # def hash
  #   [@hour, @minute].hash
  # end

  private

  def total_minutes
    (hour * MINUTES_PER_HOUR + minute) % MINUTES_PER_DAY
  end
end

