module BeerSong
  LINES = {
    0 => [
      'bottles of beer on the wall',
      'bottles of beer',
      'Go to the store and buy some more',
      'bottles of beer on the wall'
    ],
    1 => [
      'bottle of beer on the wall',
      'bottle of beer',
      'Take it down and pass it around',
      'bottles of beer on the wall'
    ],
    2 => [
      'bottles of beer on the wall',
      'bottles of beer',
      'Take one down and pass it around',
      'bottle of beer on the wall'
    ],
    3 => [
      'bottles of beer on the wall',
      'bottles of beer',
      'Take one down and pass it around',
      'bottles of beer on the wall'
    ]
  }.freeze

  def self.recite(num, verses)
    result = ''
    while verses.positive?
      n = num > 2 ? 3 : num
      result += <<~TEXT
        #{num.zero? ? 'No more' : num} #{LINES[n][0]}, #{num.zero? ? 'no more' : num} #{LINES[n][1]}.
        #{LINES[n][2]}, #{remaining_bottles(num)} #{LINES[n][3]}.#{verses > 1 ? "\n" : ''}
      TEXT
      verses -= 1
      num -= 1
    end
    result
  end

  def self.remaining_bottles(count)
    if count.zero?
      '99'
    elsif (count - 1).zero?
      'no more'
    else
      count - 1
    end
  end
end
