# frozen_string_literal: true

require 'pry'

# Food Chain
module FoodChain
  ANIMALS = [
    ['fly', "I don't know why she swallowed the fly. Perhaps she'll die."],
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
      if i > 0 || i == 7
        until i == 0
          song += <<~TEXT
            She swallowed the #{animal[0]} to catch the #{ANIMALS[i - 1][0]}.
            #{ANIMALS[i - 1][1]}
          TEXT
          i -= 1
        end
      end
    end
    
    p song
    'I know an old lady who swallowed a fly.\nI don\'t know why she swallowed the fly. Perhaps she\'ll die.'
  end

end

# each iteration builds a verse
# 8 verses