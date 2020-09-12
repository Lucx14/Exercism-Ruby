# frozen_string_literal: true

require 'pry'

# Poker
class Poker
  attr_reader :list_of_hands
  def initialize(list_of_hands)
    @list_of_hands = list_of_hands
  end

  def best_hand
    return list_of_hands if list_of_hands.length == 1

    res = []
    xy = list_of_hands.map { |hand| Hand.new(hand) }

    if xy.first.rank_position < xy.last.rank_position
      res << list_of_hands.first
    elsif xy.first.rank_position > xy.last.rank_position
      res << list_of_hands.last
    else
      xrank = xy.map(&:rank).uniq[0]
      res << compare_matching_hands(list_of_hands, xrank)
    end
    res
  end

  def compare_matching_hands(list_of_hands, rank)
    zz = list_of_hands.map { |hand| Hand.new(hand) }
    if rank == :high_card
      f = zz.first.data[:ranks].map(&:score).sort.reverse
      l = zz.last.data[:ranks].map(&:score).sort.reverse
      f.each_with_index do |score, i|
        if score > l[i]
          return list_of_hands.first
        elsif score < l[i]
          return list_of_hands.last
        end
      end
      list_of_hands
    elsif rank == :one_pair
      if zz.first.data[:pair].first.score > zz.last.data[:pair].first.score
        list_of_hands.first
      elsif zz.first.data[:pair].first.score < zz.last.data[:pair].first.score
        list_of_hands.last
      else
        if zz.first.data[:kickers].first.score > zz.last.data[:kickers].first.score
          list_of_hands.first
        elsif zz.first.data[:kickers].first.score < zz.last.data[:kickers].first.score
          list_of_hands.last
        end
      end
    elsif rank == :two_pair
      if zz.first.data[:pairs].first.first.score > zz.last.data[:pairs].first.first.score
        list_of_hands.first
      elsif zz.first.data[:pairs].first.first.score < zz.last.data[:pairs].first.first.score
        list_of_hands.last
      else
        if zz.first.data[:pairs].last.first.score > zz.last.data[:pairs].last.first.score
          list_of_hands.first
        elsif zz.first.data[:pairs].last.first.score < zz.last.data[:pairs].last.first.score
          list_of_hands.last
        else
          if zz.first.data[:kickers].first.score > zz.last.data[:kickers].first.score
            list_of_hands.first
          elsif zz.first.data[:kickers].first.score < zz.last.data[:kickers].first.score
            list_of_hands.last
          end
        end
      end
    elsif rank == :three_of_a_kind
      if zz.first.data[:triplet].first.score > zz.last.data[:triplet].first.score
        list_of_hands.first
      elsif zz.first.data[:triplet].first.score < zz.last.data[:triplet].first.score
        list_of_hands.last
      else
        if zz.first.data[:kickers].first.score > zz.last.data[:kickers].first.score
          list_of_hands.first
        elsif zz.first.data[:kickers].first.score < zz.last.data[:kickers].first.score
          list_of_hands.last
        end
      end
    elsif rank == :straight
      if zz.first.data[:ranks].first.score > zz.last.data[:ranks].first.score
        list_of_hands.first
      elsif zz.first.data[:ranks].first.score < zz.last.data[:ranks].first.score
        list_of_hands.last
      end
    elsif rank == :flush
      f = zz.first.data[:ranks].map(&:score).sort.reverse
      l = zz.last.data[:ranks].map(&:score).sort.reverse
      f.each_with_index do |score, i|
        return list_of_hands.first if score > l[i]
      end
      list_of_hands.last
    elsif rank == :full_house
      if zz.first.data[:triplet].first.score > zz.last.data[:triplet].first.score
        list_of_hands.first
      elsif zz.first.data[:triplet].first.score < zz.last.data[:triplet].first.score
        list_of_hands.last
      else
        if zz.first.data[:pair].first.score > zz.last.data[:pair].first.score
          list_of_hands.first
        elsif zz.first.data[:pair].first.score < zz.last.data[:pair].first.score
          list_of_hands.last
        end
      end
    elsif rank == :four_of_a_kind
      if zz.first.data[:quadruplet].first.score > zz.last.data[:quadruplet].first.score
        list_of_hands.first
      elsif zz.first.data[:quadruplet].first.score < zz.last.data[:quadruplet].first.score
        list_of_hands.last
      else
        if zz.first.data[:kickers].first.score > zz.last.data[:kickers].first.score
          list_of_hands.first
        elsif zz.first.data[:kickers].first.score < zz.last.data[:kickers].first.score
          list_of_hands.last
        end
      end
    elsif rank == :straight_flush
      if zz.first.data[:ranks].first.score > zz.last.data[:ranks].first.score
        list_of_hands.first
      elsif zz.first.data[:ranks].first.score < zz.last.data[:ranks].first.score
        list_of_hands.last
      end
    end
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
  RANKS = %i[straight_flush four_of_a_kind full_house flush straight three_of_a_kind two_pair one_pair high_card].freeze

  attr_reader :cards, :rank, :data

  def initialize(cards)
    @cards = cards.map { |card| Card.new(card) }
    @rank = determine_hand[:hand_rank]
    @data = determine_hand[:data]
  end

  def <=>(other)
    rank_position <=> other.rank_position
  end

  def rank_position
    RANKS.index(rank)
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
    if cards.map(&:rank).sort == %w[2 3 4 5 A]
      return cards.sort_by(&:score).take(4).reverse
    end
    
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
    return true if cards.map(&:rank).sort == %w[2 3 4 5 A]

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
