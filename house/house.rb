# frozen_string_literal: true

# House
module House
  COMPONENTS = [
    ["house that Jack built.\n"],
    ['malt', 'lay in'],
    ['rat', 'ate'],
    ['cat', 'killed'],
    ['dog', 'worried'],
    ['cow with the crumpled horn', 'tossed'],
    ['maiden all forlorn', 'milked'],
    ['man all tattered and torn', 'kissed'],
    ['priest all shaven and shorn', 'married'],
    ['rooster that crowed in the morn', 'woke'],
    ['farmer sowing his corn', 'kept'],
    ['horse and the hound and the horn', 'belonged to']
  ].freeze

  def self.recite
    rhyme = ''
    COMPONENTS.each_with_index do |component, i|
      rhyme += <<~TEXT
        This is the #{component[0]}
      TEXT

      next if i.zero?

      until i.zero?
        rhyme += <<~TEXT
          that #{COMPONENTS[i][1]} the #{COMPONENTS[i - 1][0]}
        TEXT
        i -= 1
      end
    end

    rhyme.strip + "\n"
  end
end
