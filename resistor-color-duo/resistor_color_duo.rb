module ResistorColorDuo

  BANDS = {
    Black: 0,
    Brown: 1,
    Red: 2,
    Orange: 3,
    Yellow: 4,
    Green: 5,
    Blue: 6,
    Violet: 7,
    Grey: 8,
    White: 9
  }

  def self.value(pair)
    color_1 = BANDS[pair.first.capitalize.to_sym].to_s
    color_2 = BANDS[pair.last.capitalize.to_sym].to_s
    val = color_1 + color_2
    val.to_i
  end

end
