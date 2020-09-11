# frozen_string_literal: true

require 'pry'

# Poker
class Poker
  RANKING = {
    high_card: 1,
    one_pair: 2,
    two_pair: 3,
    three_of_a_kind: 4,
    straight: 5,
    flush: 6,
    full_house: 7,
    four_of_a_kind: 8,
    straight_flush: 9,
    five_of_a_kind: 10
  }.freeze

  attr_reader :list_of_hands
  def initialize(list_of_hands)
    @list_of_hands = list_of_hands
  end

  def best_hand
    res = []
    xy = list_of_hands.each_with_index.map do |hand, index|
      hand = Hand.new(hand.map { |card| Card.new(card) })
      {rank: RANKING[hand.determine_hand[:hand_rank]], original: list_of_hands[index], index: index, hand_details: hand.determine_hand }
    end

    yy = xy.sort_by { |data| data[:rank] }

    if yy[0][:rank] > yy[1][:rank]
      res << yy[0][:original]
    end

    p res
  
    p list_of_hands
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
    'A' => 1
  }.freeze
  attr_reader :rank, :suit, :score
  def initialize(card)
    @suit = evaluate_suit(card)
    @rank = card.split('').reverse.drop(1).reverse.join
    @score = CARD_POINTS[rank]
  end

  def evaluate_suit(card)
    case card.split('').last
    when 'S' then :spades
    when 'H' then :hearts
    when 'D' then :diamonds
    when 'C' then :clubs
    else raise ArgumentError, 'invalid card!'
    end
  end
end

# Hand
class Hand
  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def suits_count
    cards.each_with_object(Hash.new(0)) { |card, hash| hash[card.suit] += 1 }
  end

  def rank_count
    cards.each_with_object(Hash.new(0)) { |card, hash| hash[card.rank] += 1 }
  end

  def determine_hand
    if straight_flush?
      { hand_rank: :straight_flush, data: { ranks: cards_sorted_by_points } }
    elsif four_of_a_kind?
      { hand_rank: :four_of_a_kind, data: { quadruplet: matched_ranks(4), kickers: hand_kickers } }
    elsif full_house?
      { hand_rank: :full_house, data: { triplet: matched_ranks(3), pair: matched_ranks(2) } }
    elsif flush?
      { hand_rank: :flush, data: { ranks: cards_sorted_by_points } }
    elsif straight?
      { hand_rank: :straight, data: { ranks: cards_sorted_by_points } }
    elsif three_of_a_kind?
      { hand_rank: :three_of_a_kind, data: { triplet: matched_ranks(3), kickers: hand_kickers } }
    elsif two_pair?
      { hand_rank: :two_pair, data: { pairs: extract_2_pairs, kickers: hand_kickers } }
    elsif one_pair?
      { hand_rank: :one_pair, data: { pair: matched_ranks(2), kickers: hand_kickers } }
    else
      { hand_rank: :high_card, data: { ranks: cards_sorted_by_points } }
    end
  end

  def consecutive_numbers?(arr)
    res = []
    high_card = arr.sort.reverse.first
    res << high_card
    4.times { res << (high_card -= 1) }
    res == arr.sort.reverse
  end

  def cards_sorted_by_points
    cards.sort_by(&:score).reverse
  end

  def straight_flush?
    rank_count.keys.length == 5 && suits_count.keys.length == 1 && consecutive_numbers?(cards.map(&:score))
  end

  def four_of_a_kind?
    rank_count.values.include?(4) && suits_count.keys.length == 4
  end

  def full_house?
    rank_count.values.include?(3) && rank_count.values.include?(2)
  end

  def flush?
    suits_count.values.include?(5)
  end

  def straight?
    consecutive_numbers?(cards.map(&:score))
  end

  def three_of_a_kind?
    rank_count.keys.length == 3 && rank_count.values.include?(3) && rank_count.values.include?(1)
  end

  def two_pair?
    rank_count.keys.length == 3 && rank_count.values.include?(2) && rank_count.values.include?(1)
  end

  def one_pair?
    rank_count.keys.length == 4 && rank_count.values.include?(2) && rank_count.values.include?(1)
  end

  def high_card?
    rank_count.keys.length == 5 && !consecutive_numbers?(cards.map(&:score)) && suits_count.keys.length > 1
  end

  def hand_kickers
    kicker_ranks = rank_count.map { |k, v| k if v == 1 }.compact
    cards.map { |card| card if kicker_ranks.include?(card.rank) }.compact.sort_by(&:score).reverse
  end

  def matched_ranks(frequency)
    rank = rank_count.map { |k, v| k if v == frequency }.compact[0]
    cards.map { |card| card if card.rank == rank }.compact
  end

  def extract_2_pairs
    ranks = rank_count.map { |k, v| k if v == 2 }.compact
    cards.map { |card| card if ranks.include?(card.rank) }.compact.sort_by(&:score).each_slice(2).to_a.reverse
  end

  # maybe a method that compare itself with another instance??
end
