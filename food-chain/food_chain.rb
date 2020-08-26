# frozen_string_literal: true

# Food Chain
module FoodChain
  ANIMALS = [
    ['fly', "I don't know why she swallowed the fly. Perhaps she'll die.\n"],
    ['spider', 'It wriggled and jiggled and tickled inside her.'],
    ['bird', 'How absurd to swallow a bird!'],
    ['cat', 'Imagine that, to swallow a cat!'],
    ['dog', 'What a hog, to swallow a dog!'],
    ['goat', 'Just opened her throat and swallowed a goat!'],
    ['cow', "I don't know how she swallowed a cow!"],
    ['horse', "She's dead, of course!"]
  ].freeze

  def self.song
    song = ''
    ANIMALS.each_with_index do |animal, i|
      song += <<~TEXT
        I know an old lady who swallowed a #{animal[0]}.
        #{animal[1]}
      TEXT
      break if i == 7

      until i.zero?
        song += <<~TEXT
          She swallowed the #{ANIMALS[i][0]} to catch the #{ANIMALS[i - 1][0]}#{(i - 1) == 1 ? ' that wriggled and jiggled and tickled inside her.' : '.'}#{i < 2 ? "\n" + ANIMALS[i - 1][1] : nil}
        TEXT
        i -= 1
      end
    end
    song
  end
end
