module Year

  def self.leap?(year)
    one = year % 4 == 0
    two = year % 100 != 0
    three = year % 400 == 0

    one && two || three
  end

end