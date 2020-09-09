# frozen_string_literal: true

require 'pry'

# Poker
class Poker
  RANKING = %i[
    high_card
    one_pair
    two_pair
    three_of_a_kind
    straight
    flush
    full_house
    four_of_a_kind
    straight_flush
    five_of_a_kind
  ].freeze

  attr_reader :list_of_hands
  def initialize(list_of_hands)
    @list_of_hands = list_of_hands
  end

  def best_hand
    pry
    p determine_class_of_hand(list_of_hands.first)
    list_of_hands
  end

  def determine_class_of_hand(hand)
    hand.map { |card| card.split('') }

  end
end

# Card
class Card
  CARD_POINTS = {
    '2' => 2,
    '3' => 3,
    '4' => 4,
    '5' => 5,
    '6' => 6,
    '7' => 7,
    '8' => 8,
    '9' => 9,
    '10' => 10,
    'J' => 11,
    'Q' => 12,
    'K' => 13,
    'A' => 14
  }.freeze
  attr_reader :rank, :suit
  def initialize(card)
    @suit = evaluate_suit(card)
    @rank = card.split('')[0]
  end

  def evaluate_suit(card)
    s = card.split('')[1]
    if s == "S"
      :spades
    elsif s == "H"
      :hearts
    elsif s == "D"
      :diamonds
    elsif s == "C"
      :clubs
    else
      raise ArgumentError, 'invalid card!'
    end
  end

  def score
    CARD_POINTS[rank]
  end
end

# Hand
class Hand
  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def hand_class

  end

end



# five cards
# are card and hand objects themselves?

# types of hand

# high_card        (high_of_jack) (high_of_queen) (high_of_8)
# one_pair         (pair_of_4)(pair_of_2)
# two_pair         (fives_and_fours)(aces_and_twos)
# three_of_a_kind  (three_of_4)(three_aces)(three_twos)
# straight         (straight)(straight_to_5)(straight_to_9)(straight_to_jack)
# flush            (flush_to_7)
# full_house       (full)(full_of_5_by_8)
# four_of_a_kind    (square_of_5)
# straight_flush    (straight_flush_to_8)
# five_of_a_kind     ???????
