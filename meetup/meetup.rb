require 'date'
class Meetup
  DAYS = %w[sunday monday tuesday wednesday thursday friday saturday].freeze
  TEENTH = (13..19).to_a.freeze
  attr_reader :month, :year

  def initialize(month, year)
    @month = month
    @year = year
  end

  def day(day, descriptor)
    day_index = DAYS.index(day.to_s)
    start_date = Date.parse("#{year}-#{month}-01")
    end_date = Date.parse("#{month == 12 ? year + 1 : year}-#{month == 12 ? 1 : month + 1}-01")

    possible_dates = (start_date...end_date).to_a.select do |date|
      date if date.wday == day_index
    end

    case descriptor
    when :first
      possible_dates.first
    when :second
      possible_dates[1]
    when :third
      possible_dates[2]
    when :fourth
      possible_dates[3]
    when :last
      possible_dates.last
    when :teenth
      possible_dates.select { |date| TEENTH.include?(date.mday) }.first
    end
  end
end
