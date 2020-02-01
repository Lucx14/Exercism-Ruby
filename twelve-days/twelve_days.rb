class TwelveDays
  ITEMS = [
    'twelve Drummers Drumming,',
    'eleven Pipers Piping,',
    'ten Lords-a-Leaping,',
    'nine Ladies Dancing,',
    'eight Maids-a-Milking,',
    'seven Swans-a-Swimming,',
    'six Geese-a-Laying,',
    'five Gold Rings,',
    'four Calling Birds,',
    'three French Hens,',
    'two Turtle Doves,',
    'and a Partridge in a Pear Tree.'
  ]
  DAY = %w(twelfth eleventh tenth ninth eighth seventh sixth fifth fourth third second first)

  def self.song
    arr = []
    song_items = ITEMS.clone

    DAY.each do |i|
      arr << "On the #{i} day of Christmas my true love gave to me: #{song_items.join(" ")}\n\n"
      song_items.shift
    end
    
    arr.last.gsub!(" and", "")
    arr.reverse.join.chomp
  end
end
