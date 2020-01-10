class Clock

  attr_reader :hour, :minute

  def initialize(hour: 0, minute: 0)
    @hour = hour
    @minute = minute
  end

  def to_s
    current_hour + ':' + current_minute
  end

  def +(clock)
    Clock.new(hour: (hour + clock.hour), minute: (minute + clock.minute))
  end

  def -(clock)
    Clock.new(hour: (hour - clock.hour), minute: (minute - clock.minute))
  end

  def ==(clock)
    self.to_s == clock.to_s
  end

  private

  def clockface_hour(num)
    if num < 24 && num >= 0
      num
    elsif num > 23
      num % 24
    elsif num < 0 && num > -25
      24 + num
    elsif num < -24
      num % 24
    end
  end

  def clockface_minute(num)
    if num < 60 && num >=0
      num
    elsif num > 59
      num % 60
    elsif num > -60 && num < 0
      60 + num
    elsif num < -59
      num % 60
    end
  end

  def hour_increment(num)
    if num > 59
      (num / 60) > 24 ? (num / 60) - 24 : (num / 60)
    elsif num < 0
      (num / 60) < -24 ? (num / 60) + 24 : (num / 60)
    else
      0
    end
  end

  def current_hour
    format_number(clockface_hour(clockface_hour(hour) + hour_increment(minute)))
  end

  def current_minute
    format_number(clockface_minute(minute))
  end

  def format_number(n)
    n < 10 ? "0#{n}" : "#{n}"
  end
end

